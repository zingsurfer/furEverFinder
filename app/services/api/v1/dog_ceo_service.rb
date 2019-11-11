class Api::V1::DogCEOService
  def initialize(type)
    @type = type
  end

  def random_dog_pic
    if !@type
      random_any_type_of_dog_pic
    else
      random_specific_type_of_dog_pic
    end
  end

  private
  
  def random_specific_type_of_dog_pic
    response = JSON.parse(response("breed/#{@type}/images/random").body)
    response["status"] !=  "error" ? response["message"] : nil
  end

  def random_any_type_of_dog_pic
    response = JSON.parse(response("breeds/image/random").body)
    response["status"] !=  "error" ? response["message"] : nil
  end

  def conn
    Faraday.new(url: "https://dog.ceo/api/") do |f|
      f.adapter Faraday.default_adapter  # make requests with HTTP
    end
  end

  def response(url)
    conn.get(url)
  end
end
