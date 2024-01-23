RSpec.shared_context "Tomorrow" do
  let(:tomorrow_realtime_mock) { 
    OpenStruct.new(body: File.read("spec/fixtures/tomorrow_api_realtime.json"))
  }
  let(:tomorrow_forecast_mock) { 
    OpenStruct.new(body: File.read("spec/fixtures/tomorrow_api_forecast.json"))
  }

  let(:client) {
    Faraday.new
  }
  before do
    allow(client).to receive(:get).with('realtime').and_return(tomorrow_realtime_mock)
    allow(client).to receive(:get).with('forecast').and_return(tomorrow_forecast_mock)
    allow_any_instance_of(
      WeatherService
    ).to receive(:client).and_return(client)
  end
end