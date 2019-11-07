class DogPicFetcher
  def initialize(type)
    @type = type
  end

  def dog_pic
    dog_pic ||= DogPic.new(random_dog_pic, random_dog_name)
  end

  private

  def random_dog_pic
    Api::V1::DogCEOService.new(@type).random_pic_of_requested_dog_type
  end

  def random_dog_name
    Faker::Superhero.name
  end
end
