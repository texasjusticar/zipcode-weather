require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  include_context "Tomorrow"

  context 'POST #display' do
    it 'primes the cache and displays the weather information for the address' do
      post :display, params: { address: 'south station boston' }

      expect(response).to be_successful
    end

    it 'redirects to the index with flash message if there is no valid address' do
      post :display, params: { address: '' }

      expect(response).to redirect_to "/"
      expect(flash[:notice]).not_to be_nil
    end
  end
end