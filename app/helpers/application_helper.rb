module ApplicationHelper
  def temperature_unit
    "°#{ @weather_data['data']['country_code'] == 'us' ? 'F' : 'C' }"
  end
end
