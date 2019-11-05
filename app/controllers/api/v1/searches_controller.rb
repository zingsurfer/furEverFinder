class Api::V1::SearchesController < ApplicationController
  def index
    if any_invalid_params?
      return render json: {error: "invalid query parameters"}, status: 400
    else
      searches = search_params[:ordered_by].nil? ? Search.all : Search.ordered_by_creation(search_params[:ordered_by])
      render json: Api::V1::SearchSerializer.new(searches).serializable_hash, status: 200
    end
  end

  private

  def search_params
    params.permit(:ordered_by)
  end

  # TODO: find a better way to achieve this
  def any_invalid_params?
    actual_param_count = params.except(:controller, :action).keys.count
    allowed_param_count = search_params.keys.count

    actual_param_count > allowed_param_count
  end
end
