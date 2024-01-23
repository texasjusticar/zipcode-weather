require 'rails_helper'

RSpec.describe ZipcodeCache do
  let(:zipcode) { '02110 us' }
  let(:service) { described_class.new(zipcode) }
  let(:data) {
    {
      "temperature" => 38.42
    }
  }

  before do
    Rails.cache.clear
  end

  context '#fetch' do
    before do
      allow(
        WeatherService
      ).to receive(:new).with(service.zipcode).and_call_original
      allow_any_instance_of(WeatherService).to receive(:execute).and_return(data)
    end

    it 'will call WeatherService and save data to the cache and return it' do
      values = service.fetch
      expect(WeatherService).to have_received(:new).once
      expect(values['data']['temperature']).to eq(38.42)
      expect(values['refresh']).to be_truthy
    end

    it 'will return data from the cache after a second hit' do
      service.fetch
      values = service.fetch
      expect(WeatherService).to have_received(:new).once
      expect(values['data']['temperature']).to eq(38.42)
      expect(values['refresh']).to be_falsey
    end
  end
end