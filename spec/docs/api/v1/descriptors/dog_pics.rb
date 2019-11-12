module Docs
  module DogPics
    extend Dox::DSL::Syntax

    document :api do
      resource 'DogPics' do
        endpoint '/api/v1/dog_pics'
        group 'furEverFinder'
      end
    end

    show_params = { type: { required: :optional, value: "corgi", description: 'type of dog' } }

    document :show do
      action 'Get a random dog pic' do
        params show_params
        desc 'This route retrieves a random dog pic & pairs it with a heroes name. If you like, you can specify what type of dog you would like to see. If it is available, furEverFinder will find it for you. Some types, like yorkshire terrier, may need to be formatted like this to specify yorkie: terrier/yorkshire.

          Searches for a random dog pic are saved to the /searches endpoint for future reference.
        '
      end
    end
  end
end
