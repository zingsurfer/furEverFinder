require 'rails_helper'

describe 'Searches', type: :request do
  include Docs::Searches::Api

  describe 'GET /api/v1/searches', type: :request do
    include Docs::Searches::Index

    it 'has response headers' do
      get '/api/v1/searches'

      expect(response.header["Accept"]).to eq("application/json")
      expect(response.header["Content-Type"]).to eq("application/json")
    end

    context 'with data' do
      before(:all) do
        create(:search,
          topic: 'ancient_search',
          created_at: Time.zone.now - 5.day,
          updated_at: Time.zone.now - 5.day
        )
        create(:search,
          topic: 'finn',
          created_at: Time.zone.now - 4.day,
          updated_at: Time.zone.now - 4.day
        )
        create(:search,
          topic: 'jake',
          created_at: Time.zone.now - 3.day,
          updated_at: Time.zone.now - 3.day
        )
        create(:search,
          topic: 'finn',
          created_at: Time.zone.now - 2.day,
          updated_at: Time.zone.now - 2.day)
        create(:search,
          topic: 'jake',
          created_at: Time.zone.now - 1.day,
          updated_at: Time.zone.now - 1.day
        )
        create(:search,
          topic: 'newest_search_ever',
          created_at: Time.zone.now,
          updated_at: Time.zone.now
        )
      end

      let!(:test_searches) { Search.all }
      let!(:oldest_search) { test_searches.first }
      let!(:newist_search) { test_searches.last }
      let!(:oldest_finn_search) { test_searches[1] }
      let!(:oldest_jake_search) { test_searches[2] }
      let!(:newist_finn_search) { test_searches[3] }
      let!(:newist_jake_search) { test_searches[4] }

      context 'when valid' do
        it 'returns searches', :dox do
          get '/api/v1/searches'

          searches = JSON.parse(response.body)

          expect(response).to be_successful
          expect(searches["data"][0].keys).to match_array(["id", "type", "attributes"])
          expect(searches["data"][0]["attributes"].keys).to match_array(["topic", "url", "updated_at", "created_at"])
        end

        it 'returns searches ordering by newist', :dox do
          get '/api/v1/searches?ordered_by=newist_created'

          searches = JSON.parse(response.body)

          expect(response).to be_successful
          expect(searches["data"][0].keys).to match_array(["id", "type", "attributes"])
          expect(searches["data"][0]["attributes"].keys).to match_array(["topic", "url", "updated_at", "created_at"])

          # Check that searches are ordered with newist created records first
          expect(searches["data"].first["id"]).to eq(newist_search.id.to_s)
          expect(searches["data"][1]["id"]).to eq(newist_jake_search.id.to_s)
          expect(searches["data"][2]["id"]).to eq(newist_finn_search.id.to_s)
          expect(searches["data"][3]["id"]).to eq(oldest_jake_search.id.to_s)
          expect(searches["data"][4]["id"]).to eq(oldest_finn_search.id.to_s)
          expect(searches["data"].last["id"]).to eq(oldest_search.id.to_s)
        end

        it 'returns searches ordering by oldest', :dox do
          get '/api/v1/searches?ordered_by=oldest_created'

          searches = JSON.parse(response.body)

          expect(response).to be_successful
          expect(searches["data"][0].keys).to match_array(["id", "type", "attributes"])
          expect(searches["data"][0]["attributes"].keys).to match_array(["topic", "url", "updated_at", "created_at"])

          # Check that searches are ordered with oldest created records first
          expect(searches["data"].first["id"]).to eq(oldest_search.id.to_s)
          expect(searches["data"][1]["id"]).to eq(oldest_finn_search.id.to_s)
          expect(searches["data"][2]["id"]).to eq(oldest_jake_search.id.to_s)
          expect(searches["data"][3]["id"]).to eq(newist_finn_search.id.to_s)
          expect(searches["data"][4]["id"]).to eq(newist_jake_search.id.to_s)
          expect(searches["data"].last["id"]).to eq(newist_search.id.to_s)
        end

        it 'returns searches sorted by topic', :dox do
          get "/api/v1/searches?sorted_by_topic=true"

          searches = JSON.parse(response.body)

          expect(response).to be_successful
          expect(searches["data"][0].keys).to match_array(["id", "type", "attributes"])
          expect(searches["data"][0]["attributes"].keys).to match_array(["topic", "url", "updated_at", "created_at"])

          # Check that searches are alphabetically sorted by topic
          expect(searches["data"].first["id"]).to eq(oldest_search.id.to_s)
          expect(searches["data"][1]["id"]).to eq(oldest_finn_search.id.to_s)
          expect(searches["data"][2]["id"]).to eq(newist_finn_search.id.to_s)
          expect(searches["data"][3]["id"]).to eq(oldest_jake_search.id.to_s)
          expect(searches["data"][4]["id"]).to eq(newist_jake_search.id.to_s)
          expect(searches["data"].last["id"]).to eq(newist_search.id.to_s)
        end

        it 'returns searches filtered by topic', :dox do
          topic = "finn"
          get "/api/v1/searches?topic=#{topic}"

          searches = JSON.parse(response.body)

          expect(response).to be_successful
          expect(searches["data"][0].keys).to match_array(["id", "type", "attributes"])
          expect(searches["data"][0]["attributes"].keys).to match_array(["topic", "url", "updated_at", "created_at"])
          searches["data"].each do |search|
            expect(search["attributes"]["topic"]).to eq(topic)
          end
        end
      end
      context 'when invalid' do
        it 'errors for invalid param keys', :dox do
          invalid_key = 'skydiver'
          valid_value = 'newist'

          get "/api/v1/searches?#{invalid_key}=#{valid_value}"

          searches = JSON.parse(response.body)

          expect(response).to have_http_status(400)
          expect(searches["error"]).to eq("Invalid query parameter(s): #{invalid_key}. Please verify the query parameter name(s).")
        end

        it 'errors for currently unsupported param combinations', :dox do
          get "/api/v1/searches?sorted_by_topic=true&ordered_by=newist_created"

          searches = JSON.parse(response.body)

          puts searches["data"]
          expect(response).to have_http_status(400)
          expect(searches["error"]).to eq("Query parameter combo is currently unsupported: ordered_by and sorted_by_topic.")
        end

        it 'errors for an invalid ordered_by param value', :dox do
          valid_key = 'ordered_by'
          invalid_value = 'avocado'

          get "/api/v1/searches?#{valid_key}=#{invalid_value}"

          searches = JSON.parse(response.body)

          expect(response).to have_http_status(422)
          expect(searches["error"]).to eq("Unpermitted value for #{valid_key}: #{invalid_value}. Please verify the query parameter value(s).")
        end

        it 'errors for an invalid sorted_by_topic param value', :dox do
          valid_key = 'sorted_by_topic'
          invalid_value = 'avocado'

          get "/api/v1/searches?#{valid_key}=#{invalid_value}"

          searches = JSON.parse(response.body)

          expect(response).to have_http_status(422)
          expect(searches["error"]).to eq("Unpermitted value for #{valid_key}: #{invalid_value}. Please verify the query parameter value(s).")
        end
      end
    end
    context 'without data' do
      before(:all) do
        Search.delete_all
      end
      context 'when valid' do
        it 'returns an empty array if no searches exist', :dox do
          get '/api/v1/searches'

          searches = JSON.parse(response.body)

          expect(response).to be_successful
          expect(searches["data"]).to eq([])
        end
      end
      context 'when invalid' do
        it 'errors for an invalid param key', :dox do
          valid_param = 'ordered_by'
          valid_value = 'oldest'
          invalid_key = 'galapagos'

          get "/api/v1/searches?#{invalid_key}=#{valid_value}&#{valid_param}=#{valid_value}"

          searches = JSON.parse(response.body)

          expect(response).to have_http_status(400)
          expect(searches["error"]).to eq(
            "Invalid query parameter(s): #{invalid_key}. Please verify the query parameter name(s)."
          )
        end

        it 'errors for invalid param keys', :dox do
          valid_param = 'ordered_by'
          valid_value = 'newist'
          invalid_key_1 = 'kiwi'
          invalid_key_2 = 'mango'
          invalid_key_3 = 'melon'

          get "/api/v1/searches?#{invalid_key_1}=#{valid_value}&#{invalid_key_2}=#{valid_value}&#{invalid_key_3}=#{valid_value}&#{valid_param}"

          searches = JSON.parse(response.body)

          expect(response).to have_http_status(400)
          expect(searches["error"]).to eq(
            "Invalid query parameter(s): #{invalid_key_1}, #{invalid_key_2}, and #{invalid_key_3}. Please verify the query parameter name(s)."
          )
        end

        it 'errors for an unsupported param combo', :dox do
          get "/api/v1/searches?sorted_by_topic=true&ordered_by=newist_created"

          searches = JSON.parse(response.body)

          puts searches["data"]
          expect(response).to have_http_status(400)
          expect(searches["error"]).to eq("Query parameter combo is currently unsupported: ordered_by and sorted_by_topic.")
        end

        it 'errors for an invalid ordered_by param value', :dox do
          valid_key = 'ordered_by'
          invalid_value = 'avocado'

          get "/api/v1/searches?#{valid_key}=#{invalid_value}"

          searches = JSON.parse(response.body)

          expect(response).to have_http_status(422)
          expect(searches["error"]).to eq("Unpermitted value for ordered_by: avocado. Please verify the query parameter value(s).")
        end

        it 'errors for an invalid sorted_by_topic param value', :dox do
          valid_key = 'sorted_by_topic'
          invalid_value = 'avocado'

          get "/api/v1/searches?#{valid_key}=#{invalid_value}"

          searches = JSON.parse(response.body)

          expect(response).to have_http_status(422)
          expect(searches["error"]).to eq("Unpermitted value for #{valid_key}: #{invalid_value}. Please verify the query parameter value(s).")
        end
      end
    end
  end
end
