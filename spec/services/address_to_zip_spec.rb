require 'rails_helper'

RSpec.describe 'AddressToZip' do
  let(:geocoder_mock) do
    mock = OpenStruct.new(
      postal_code: '02110',
      country_code: 'us',
      city: 'Boston',
      house_number: '700',
      street: 'Atlantic AVenue'
    ) 
    [mock]
  end

  context '#execute' do
    let(:address) { '700 Atlantic Avenue Boston' }

    context 'valid data' do
      
      before do
        allow(Geocoder).to receive(:search).and_return(geocoder_mock)
      end

      it 'will return the zipcode for an address' do
        expect(
          AddressToZip.execute(address)
        ).to eq(
          '02110 us'
        )
      end
    end

    context 'invalid data' do
      before do
        allow(Geocoder).to receive(:search).and_return([])
      end
      
      it 'will raise InvalidAddress if geocoder cannot find a zipcode' do
        expect{
          AddressToZip.execute(address)
      }.to raise_error(AddressToZip::InvalidAddress)
      end
    end
  end
end