class Api::V1::SearchSerializer
  include FastJsonapi::ObjectSerializer
  attributes :topic, :url, :created_at, :updated_at
end
