require 'rails_helper'

describe 'GET /api/v1/searches' do
  it 'returns searches with a valid request' do
    get "/api/v1/searches"

    searches = JSON.parse(response.body)

    expect(response).to be_successful
  end
end
