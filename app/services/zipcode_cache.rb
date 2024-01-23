class ZipcodeCache

  attr_accessor :zipcode

  def initialize(zipcode_with_country)
    @zipcode = zipcode_with_country
  end

  # example Hash of values cached using tomorrow.io api:
  # {
  #   "cloudBase"=>0.12,
  #   "cloudCeiling"=>0.12,
  #   "cloudCover"=>100,
  #   "dewPoint"=>7.81,
  #   "freezingRainIntensity"=>0,
  #   "humidity"=>93,
  #   "precipitationProbability"=>20,
  #   "pressureSurfaceLevel"=>1007.25,
  #   "rainIntensity"=>0.13,
  #   "sleetIntensity"=>0,
  #   "snowIntensity"=>0,
  #   "temperature"=>8.81,
  #   "temperatureApparent"=>8.81,
  #   "uvHealthConcern"=>0,
  #   "uvIndex"=>0,
  #   "visibility"=>15.58,
  #   "weatherCode"=>1001,
  #   "windDirection"=>208.63,
  #   "windGust"=>13.63,
  #   "windSpeed"=>7.88
  # }

  def fetch
    @cache_refresh = false

    data = Rails.cache.fetch(tomorrow_cache_key, expires_in: 30.minutes) do
      @cache_refresh = true
      WeatherService.new(zipcode).execute
    end

    { 'data' => data, 'refresh' => @cache_refresh }
  end

  private

  def tomorrow_cache_key
    "#{zipcode.gsub(/\s+/, "")}/weather"
  end
end