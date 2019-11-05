require 'rails_helper'

RSpec.describe 'GET /api/v1/searches', type: :request do
  context 'without data' do
    it 'returns an empty array for general requests' do
      get "/api/v1/searches"

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
    end

    it 'returns an empty array for requests ordering by newist' do
      get "/api/v1/searches?ordered_by=newist"

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
    end

    it 'returns an empty array for requests ordering by oldest' do
      get "/api/v1/searches?ordered_by=oldest"

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
    end

    it 'returns error response for requests with invalid param keys' do

      get "/api/v1/searches?zebras=newist"

      searches = JSON.parse(response.body)

      expect(response).to have_http_status(400)
      expect(searches["error"]).to eq("invalid parameter key")
    end

    it 'returns an empty array for requests with invalid param values' do

      get "/api/v1/searches?ordered_by=doesnotcompute"

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
    end
  end

  context 'with data' do
    let!(:searches) { create_list(:search, 3)}

    it 'returns searches for general requests' do

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

    it 'returns searches for requests ordering by newist' do
      get "/api/v1/searches?ordered_by=newist"

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"][0]).to have_key("id")
      expect(searches["data"][0]).to have_key("type")
      expect(searches["data"][0]).to have_key("attributes")
      expect(searches["data"][0]["attributes"]).to have_key("url")
      expect(searches["data"][0]["attributes"]).to have_key("created_at")
      expect(searches["data"][0]["attributes"]).to have_key("updated_at")
    end

    it 'returns searches for requests ordering by oldest' do

      get "/api/v1/searches?ordered_by=oldest"

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"][0]).to have_key("id")
      expect(searches["data"][0]).to have_key("type")
      expect(searches["data"][0]).to have_key("attributes")
      expect(searches["data"][0]["attributes"]).to have_key("url")
      expect(searches["data"][0]["attributes"]).to have_key("created_at")
      expect(searches["data"][0]["attributes"]).to have_key("updated_at")
    end

    it 'returns error response for requests with invalid param keys' do
      get "/api/v1/searches?invalid_kayak=newist"

      searches = JSON.parse(response.body)

      expect(response).to have_http_status(400)
      expect(searches["error"]).to eq("invalid parameter key")
    end

    it 'returns an empty array for requests with invalid param values' do
      get "/api/v1/searches?ordered_by=doesnotcompute"

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
    end
  end
end
