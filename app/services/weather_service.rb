class WeatherService

  attr_accessor :zipcode, :country_code, :units, :response

  def initialize(zipcode)
    @zipcode = zipcode
    @country_code = Geocoder.search(zipcode).first.country_code
    @units = (@country_code == 'us') ? 'imperial' : 'metric'
  end

  def execute
    @response = client.get('realtime') do |req|
      req.params = tomorrow_params
    end

    current_values = tomorrow_api_values
    current_values['country_code'] = country_code
    current_values.merge!(min_max_temp_values)
  end
  
  private 

  def client
    Faraday.new(
      url: tomorrow_uri,
      headers: {'Content-Type' => 'application/json'}
    )
  end

  def response_data
    JSON.parse(response.body)
  end

  def tomorrow_api_key
    ENV['TOMORROW_API_KEY']
  end

  def tomorrow_params
    { 
      location: "#{zipcode} #{country_code}",
      apikey: tomorrow_api_key,
      units: units
    }
  end

  def tomorrow_uri
    'https://api.tomorrow.io/v4/weather'
  end

  def tomorrow_api_values
    response_data['data']['values']
  end

  def min_max_temp_values
    @response = client.get('forecast') do |req|
      req.params=tomorrow_params.merge!(timesteps: '1d')
    end

    forecast_data = response_data['timelines']['daily'].first['values']

    {
      'min_temperature' => forecast_data['temperatureMin'],
      'max_temperature' => forecast_data['temperatureMax']
    }
  end
end