module Docs
  module DogPics
    extend Dox::DSL::Syntax

    document :api do
      resource 'DogPics' do
        endpoint '/api/v1/dog_pics'
        group 'DogPics'
      end
    end

    document :show do
      action 'Get an awesome dog pic'
    end
  end
end
