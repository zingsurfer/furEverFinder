require 'rails_helper'

describe 'DESTROY /api/v1/searches/:id', type: :request do

  context 'when valid' do
    it 'deletes a record' do
      create(:search)
      id = create(:search).id

      delete "/api/v1/searches/#{id}"

      expect(response).to have_http_status(204)

      # Test that expected record is destroyed
      expect(Search.all.length).to eq(1)
      expect(Search.last.id).to_not eq(id)
    end
  end

  context 'when invalid' do
    it 'returns a 404' do
      delete "/api/v1/searches/999"

      search = JSON.parse(response.body)

      expect(response).to have_http_status(404)
      expect(search["error"]).to eq("Record not found.")
    end
  end
end
