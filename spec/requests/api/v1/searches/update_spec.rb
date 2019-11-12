require 'rails_helper'

describe 'Searches', type: :request do
  include Docs::Searches::Api

  describe 'PATCH /api/v1/searches/:id', type: :request do
    include Docs::Searches::Update

    context 'when valid' do
      it 'updates a search record', :dox do
        previous_topic = "snorkeling_elephants"
        updated_topic = "skydiving_penguins"
        id = create(:search, topic: previous_topic).id

        patch "/api/v1/searches/#{id}", params: { search: { topic: updated_topic } }

        search = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(search.class).to eq(Hash)
        expect(search["data"].keys).to match_array(["id", "type", "attributes"])
        expect(search["data"]["attributes"].keys).to match_array(["topic", "url", "updated_at", "created_at"])
        expect(response.header["Accept"]).to eq("application/json")
        expect(response.header["Content-Type"]).to eq("application/json")

        # Test that expected record is updated & returned
        expect(search["data"]["id"]).to eq(id.to_s)
        expect(search["data"]["attributes"]["url"]).to eq(Search.last.url)
        expect(search["data"]["attributes"]["topic"]).to eq(updated_topic)
      end
    end

    context 'when invalid' do
      it 'returns a 404 if requesting to update an unfound search', :dox do
        patch "/api/v1/searches/999", params: {search: {topic: "kayaking_giraffes"}}

        search = JSON.parse(response.body)

        expect(response).to have_http_status(404)
        expect(search["error"]).to eq("Record not found.")
      end

      it 'returns an invalid payload error for empty payloads', :dox do
        id = create(:search).id

        patch "/api/v1/searches/#{id}"

        search = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(search["error"]).to eq("Invalid payload: param is missing or the value is empty: search.")
      end

      it 'returns an invalid param error for invalid payloads', :dox do
        id = create(:search).id

        patch "/api/v1/searches/#{id}", params: { search: { url: "www.cat-facts.com"} }

        search = JSON.parse(response.body)

        expect(response).to have_http_status(400)
        expect(search["error"]).to eq("Invalid query parameter(s): url. Please verify the query parameter name(s).")
      end
    end
  end
end
