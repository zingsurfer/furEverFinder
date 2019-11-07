require 'rails_helper'

RSpec.describe 'GET /api/v1/dog_pics/random', type: :request do
  it 'returns a successful response when expected' do
    get '/api/v1/dog_pics/random?type=corgi'
    
    expect(response).to be_successful
  end

  it 'returns an error when a pic does not exist' do
    get '/api/v1/dog_pics/random?type=coOrgi'

    dog_pic = JSON.parse(response.body)

    expect(response).to have_http_status(404)
    expect(dog_pic["error"]).to eq("furEverFinder couldn't find a pic.")
  end
end
