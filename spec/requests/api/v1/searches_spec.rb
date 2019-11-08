require 'rails_helper'

RSpec.describe 'GET /api/v1/searches', type: :request do
  context 'without data' do
    it 'returns an empty array for general requests' do
      get '/api/v1/searches'

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    it 'returns an empty array for requests ordering by newist' do
      get '/api/v1/searches?ordered_by=newist'

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    it 'returns an empty array for requests ordering by oldest' do
      get '/api/v1/searches?ordered_by=oldest'

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    it 'returns expected error for requests with an invalid param key' do
      valid_param = 'ordered_by'
      valid_value = 'oldest'
      invalid_param = 'galapagos'

      get "/api/v1/searches?#{invalid_param}=#{valid_value}&#{valid_param}=#{valid_value}"

      searches = JSON.parse(response.body)

      expect(response).to have_http_status(400)
      expect(searches["error"]).to eq(
        "Invalid query parameter(s): #{invalid_param}. Please verify the query parameter name(s)."
      )
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    it 'returns expected error for requests with multiple invalid param keys' do
      valid_param = 'ordered_by'
      valid_value = 'newist'
      invalid_param_1 = 'kiwi'
      invalid_param_2 = 'mango'
      invalid_param_3 = 'melon'

      get "/api/v1/searches?#{invalid_param_1}=#{valid_value}&#{invalid_param_2}=#{valid_value}&#{invalid_param_3}=#{valid_value}&#{valid_param}"

      searches = JSON.parse(response.body)

      expect(response).to have_http_status(400)
      expect(searches["error"]).to eq(
        "Invalid query parameter(s): #{invalid_param_1}, #{invalid_param_2}, and #{invalid_param_3}. Please verify the query parameter name(s)."
      )
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    it 'returns an empty array for requests with invalid param values' do

      get '/api/v1/searches?ordered_by=doesnotcompute'

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end
  end

  context 'with data' do
    let!(:searches) { create_list(:search, 3)}

    it 'returns searches for general requests' do

      get '/api/v1/searches'

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"][0]).to have_key("id")
      expect(searches["data"][0]).to have_key("type")
      expect(searches["data"][0]).to have_key("attributes")
      expect(searches["data"][0]["attributes"]).to have_key("topic")
      expect(searches["data"][0]["attributes"]).to have_key("url")
      expect(searches["data"][0]["attributes"]).to have_key("created_at")
      expect(searches["data"][0]["attributes"]).to have_key("updated_at")
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    it 'returns searches for requests ordering by newist' do
      get '/api/v1/searches?ordered_by=newist'

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"][0]).to have_key("id")
      expect(searches["data"][0]).to have_key("type")
      expect(searches["data"][0]).to have_key("attributes")
      expect(searches["data"][0]["attributes"]).to have_key("topic")
      expect(searches["data"][0]["attributes"]).to have_key("url")
      expect(searches["data"][0]["attributes"]).to have_key("created_at")
      expect(searches["data"][0]["attributes"]).to have_key("updated_at")
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    it 'returns searches for requests ordering by oldest' do

      get '/api/v1/searches?ordered_by=oldest'

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"][0]).to have_key("id")
      expect(searches["data"][0]).to have_key("type")
      expect(searches["data"][0]).to have_key("attributes")
      expect(searches["data"][0]["attributes"]).to have_key("topic")
      expect(searches["data"][0]["attributes"]).to have_key("url")
      expect(searches["data"][0]["attributes"]).to have_key("created_at")
      expect(searches["data"][0]["attributes"]).to have_key("updated_at")
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    it 'returns error response for requests with invalid param keys' do
      invalid_param = 'skydiver'
      valid_value = 'newist'

      get "/api/v1/searches?#{invalid_param}=#{valid_value}"

      searches = JSON.parse(response.body)

      expect(response).to have_http_status(400)
      expect(searches["error"]).to eq("Invalid query parameter(s): #{invalid_param}. Please verify the query parameter name(s).")
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    it 'returns an empty array for requests with invalid param values' do
      get "/api/v1/searches?ordered_by=doesnotcompute"

      searches = JSON.parse(response.body)

      expect(response).to be_successful
      expect(searches["data"]).to eq([])
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end
  end
end
