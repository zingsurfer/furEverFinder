require 'rails_helper'

describe 'POST /api/v1/searches/:id', type: :request do

  context 'when valid' do
    it 'creates a search record' do
      url = "https://matthewrayfield.com/goodies/inspect-this-snake/"
      topic = "games"

      post "/api/v1/searches", params: { search: { url: url, topic: topic } }

      search = JSON.parse(response.body)

      expect(response).to have_http_status(201)
      expect(search["data"].keys).to match_array(["id", "type", "attributes"])
      expect(search["data"]["attributes"].keys).to match_array(["topic", "url", "updated_at", "created_at"])
      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")

      # Test that expected record is created & returned
      expect(search["data"]["attributes"]["url"]).to eq(Search.last.url)
      expect(search["data"]["attributes"]["url"]).to eq(url)
      expect(search["data"]["attributes"]["topic"]).to eq(topic)
    end
  end

  context 'when invalid' do
    it 'returns an error' do
      url = "https://matthewrayfield.com/goodies/inspect-this-snake/"
      create(:search, url: url)

      post "/api/v1/searches", params: { search: { url: url } }

      search = JSON.parse(response.body)

      expect(response).to have_http_status(400)
      expect(search["error"]).to eq("Mysterious validation error: it's possible this search url may already be saved.")
    end
  end
end
