require 'rails_helper'

RSpec.describe 'GET /api/v1/dog_pics/random', type: :request do
  context 'valid request' do
    it 'returns a pic and saves the search with params' do
      get '/api/v1/dog_pics/random?type=corgi'

      expect(Search.all.length()).to eq(1)
      expect(response).to be_successful
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end
    it 'returns a pic and saves the search without params' do
      get '/api/v1/dog_pics/random'

      expect(Search.all.length()).to eq(1)
      expect(response).to be_successful
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end
  end
  context 'invalid request' do
    it 'errors for nonexistant pics and does not save the search' do
      get '/api/v1/dog_pics/random?type=coOrgi'

      dog_pic = JSON.parse(response.body)

      expect(Search.all.length()).to eq(0)
      expect(response).to have_http_status(404)
      expect(dog_pic["error"]).to eq("furEverFinder couldn't find a pic.")
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    it 'errors for an invalid param key and does not save the search ' do
      invalid_param = "cat"
      get "/api/v1/dog_pics/random?#{invalid_param}=coOrgi"

      dog_pic = JSON.parse(response.body)

      expect(Search.all.length()).to eq(0)
      expect(response).to have_http_status(400)
      expect(dog_pic["error"]).to eq(
        "Invalid query parameter(s): #{invalid_param}. Please verify the query parameter name(s)."
      )
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end
  end
end
