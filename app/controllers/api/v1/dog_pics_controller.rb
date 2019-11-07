class Api::V1::DogPicsController < ApplicationController
  def show
    find = DogPicFetcher.new(params[:type]).dog_pic

    if find.image_url == nil
      render json: {error: "furEverFinder couldn't find a pic."}, status: 404
    else
      render json: find, status: 200
    end
  end
end
