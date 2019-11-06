require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'validations' do
    subject { Search.new(url: "https://api.petfinder.com/v2/animals?type=dog&page=2")}
    it {should validate_uniqueness_of(:url)}
    it {should validate_presence_of(:url)}
  end
end
