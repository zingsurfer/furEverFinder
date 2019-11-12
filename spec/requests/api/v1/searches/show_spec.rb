require 'rails_helper'

describe 'Searches', type: :request do
  include Docs::Searches::Api

  describe 'GET /api/v1/searches/:id', type: :request do
    include Docs::Searches::Show

    context 'when valid' do
      it 'sends a single search', :dox do
        id = create(:search).id

        get "/api/v1/searches/#{id}"

        search = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(search.class).to eq(Hash)
        expect(search["data"].keys).to match_array(["id", "type", "attributes"])
        expect(search["data"]["attributes"].keys).to match_array(["topic", "url", "updated_at", "created_at"])
        expect(response.header["Accept"]).to eq("application/json")
        expect(response.header["Content-Type"]).to eq("application/json")

        # Test that expected record is returned
        expect(search["data"]["id"]).to eq(id.to_s)
        expect(search["data"]["attributes"]["url"]).to eq(Search.last.url)
      end
    end

    context 'when invalid' do
      it 'returns a 404 when a search is not found', :dox do
        get "/api/v1/searches/999"

        search = JSON.parse(response.body)

        expect(response).to have_http_status(404)
        expect(search["error"]).to eq("Record not found.")
      end
    end
  end
end
