Hello world!

# Group DogPics


## DogPics [/api/v1/dog_pics]


### Get an awesome dog pic [GET /api/v1/dog_pics/random]


+ Request returns a pic and saves the search without params
**GET**&nbsp;&nbsp;`/api/v1/dog_pics/random`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "image_url": "https://images.dog.ceo/breeds/poodle-miniature/n02113712_335.jpg",
              "name": "General Thunderbird"
            }
