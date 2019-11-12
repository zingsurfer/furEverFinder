module Docs
  module Searches
    extend Dox::DSL::Syntax

    document :api do
      resource 'Searches' do
        endpoint '/api/v1/searches'
        group 'furEverFinder'
      end
    end

    document :create do
      action 'Create a search' do
        desc 'Want to save more searches than searches of dog pics? This route enables you to create a search record. You are welcome to include a topic, or you can just use the default topic: misc.'
      end
    end

    document :index do
      action 'Get an index of searches' do
        desc 'This route gets all the searches. If you like, you can filter the results by topic, order them by creation, or sort them by topic.'
      end
    end

    document :show do
      action 'Get a search by id' do
        desc 'This route retrieves a search by its id.'
      end
    end

    document :update do
      action 'Update the topic of a search' do
        desc 'This route enables you to update the topic of a search. Currently, no other fields are updatable.'
      end
    end

    document :destroy do
      action 'Delete a search' do
        desc "Didn't want to actually save that search? No worries! This route enables you to delete a search."
      end
    end
  end
end
