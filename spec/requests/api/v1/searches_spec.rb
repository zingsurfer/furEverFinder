require 'rails_helper'

RSpec.describe 'GET /api/v1/searches', type: :request do
  context 'when no data exists' do
    it 'returns an empty array for valid requests' do
      get "/api/v1/searches"

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
    end
  end

  context 'when data exists' do
    let!(:searches) { create_list(:search, 3)}

    it 'returns searches for valid requests' do

      get "/api/v1/searches"

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"][0]).to have_key("id")
      expect(searches["data"][0]).to have_key("type")
      expect(searches["data"][0]).to have_key("attributes")
      expect(searches["data"][0]["attributes"]).to have_key("url")
      expect(searches["data"][0]["attributes"]).to have_key("created_at")
      expect(searches["data"][0]["attributes"]).to have_key("updated_at")
    end
  end
end
