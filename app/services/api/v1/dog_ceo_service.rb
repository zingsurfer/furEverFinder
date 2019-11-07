class Api::V1::DogCEOService
  def initialize(type)
    @type = type
  end

  def random_pic_of_requested_dog_type
    response = JSON.parse(response("#{@type}/images/random").body)
    response["status"] !=  "error" ? response["message"] : nil
  end

  private
  def conn
    Faraday.new(url: "https://dog.ceo/api/breed/") do |f|
      f.adapter Faraday.default_adapter  # make requests with HTTP
    end
  end

  def response(url)
    conn.get(url)
  end
end
