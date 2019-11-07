class DogPic
  attr_reader :image_url,
              :name

  def initialize(image_url, name)
    @image_url = image_url
    @name = name
  end
end
