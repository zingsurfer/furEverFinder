class Api::V1::SearchesController < ApplicationController
  def index
    searches = Search.all
    render json: Api::V1::SearchSerializer.new(searches).serializable_hash, status: 200
  end
end
