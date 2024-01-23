require 'rails_helper'

RSpec.describe WeatherService do
  let(:zipcode) { '02110 us' }
  let(:service) { described_class.new(zipcode) }

  it 'will assign the correct country code' do
    expect(service.country_code).to eq('us')
  end

  it 'will assign the correct units' do
    expect(service.units).to eq('imperial')
  end

  include_context "Tomorrow"

  context '#execute' do
    context 'valid data' do
      it 'will return the weather values for the zipcode' do
        values = service.execute
        expect(
          values["temperature"]
        ).to eq(
          38.53
        )
      end

      it 'will acquire the forecasted min/max temperatures and return it' do
        values = service.execute
        expect(
          values["min_temperature"]
        ).to eq(
          33.12
        )
      end

      it 'will return the country code with the weather data' do
        values = service.execute
        expect(
          values["country_code"]
        ).to eq(
          'us'
        )
      end
    end
  end
end