class Api::V1::SearchesController < ApplicationController
  def index
    searches = search_params[:ordered_by].nil? ? Search.all : Search.ordered_by_creation(search_params[:ordered_by])

    render json: Api::V1::SearchSerializer.new(searches).serializable_hash, status: 200
  end

  private

  def search_params
    params.permit(:ordered_by)
  end
end
