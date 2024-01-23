class WeatherController < ApplicationController
  def index
  end

  def display
    @zipcode = AddressToZip.execute(params[:address])
    @weather_data = ZipcodeCache.new(@zipcode).fetch
  rescue AddressToZip::InvalidAddress
    flash[:notice] = "The address was invalid, please try another one"
    redirect_to action: :index
  end
end