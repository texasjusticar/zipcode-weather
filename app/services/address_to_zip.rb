class AddressToZip
  class InvalidAddress < StandardError; end

  def self.execute(address)
    results = Geocoder.search(address)

    raise InvalidAddress unless results&.first&.postal_code

    "#{results.first.postal_code} #{results.first.country_code}"
  end
end