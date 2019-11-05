class Api::V1::SearchesController < ApplicationController
  def index
    if params.keys.count - 2 > search_params.keys.count
      return render json: {error: "invalid parameter key"}, status: 400
    else
      searches = search_params[:ordered_by].nil? ? Search.all : Search.ordered_by_creation(search_params[:ordered_by])
      render json: Api::V1::SearchSerializer.new(searches).serializable_hash, status: 200
    end
  end

  private

  def search_params
    params.permit(:ordered_by)
  end
end
