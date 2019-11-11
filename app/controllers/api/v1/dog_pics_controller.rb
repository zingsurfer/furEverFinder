class Api::V1::DogPicsController < ApplicationController
  def show
    find = DogPicFetcher.new(dog_pic_params[:type]).dog_pic

    if find.image_url == nil
      render json: { error: "furEverFinder couldn't find a pic." }, status: 404
    else
      # TODO: Could move search saving to a job queue with Sidekiq
      search_url = request.original_url
      Search.create(url: search_url, topic: "dog_pics")

      render json: find, status: 200
    end
  end

  private

  def dog_pic_params
    params.permit(:type)
  end
end
