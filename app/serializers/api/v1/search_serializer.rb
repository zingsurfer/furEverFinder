class Api::V1::SearchSerializer
  include FastJsonapi::ObjectSerializer
  attributes :url, :created_at, :updated_at
end
