# furEverFinder

### Intro
furEverFinder is an API for saving and fetching your searches!

furEverFinder endeavors to save your searches so that finds for the same search query will be more accessible the next time you search. furEverFinder features CRUD functionality if you would like to, say, save a search for skydiving penguins.

But if you have no idea where to start, it also consumes the Dog CEO API (a random dog pic generator that enables you to specify a type of dog if you like). After you search for a random dog pic at `/api/v1/dog_pics/random`, head over to `/api/v1/searches`. If there's a dog and the search is unique, you will see it added to the list.

Welcome to the deployed app! If you'd like to take a look at its origins, check this out: https://github.com/Autumn-Martin/furEverFinder. Ideas & feedback are welcome.

### Goals
The primary purpose of this project was to adventure with building a Ruby on Rails API that: exposes RESTful endpoints and provides the ability to sort & filter searches. This project is also being used as a jumping off point for experimenting, like it did with the living documentation feature.

### Future Goals
In the future, this API could consume an API that offers a search engine for cat & dog adoptions, and save users searches to expedite finding a furEverFriend. Other future goals for this project include adding:
* A demo
* Caching & throttling
* Queuing with Sidekiq
* Option to order searches by last request
* Authentication
* Pagination

### Easy links
- GitHub: https://github.com/Autumn-Martin/furEverFinder
- Searches (Index): https://fur-ever-finder.herokuapp.com/api/v1/searches
- Random dog pic: https://fur-ever-finder.herokuapp.com/api/v1/dog_pics/random

# Group furEverFinder


## DogPics [/api/v1/dog_pics]


### Get a random dog pic [GET /api/v1/dog_pics/random]
This route retrieves a random dog pic & pairs it with a heroes name. If you like, you can specify what type of dog you would like to see. If it is available, furEverFinder will find it for you. Some types, like yorkshire terrier, may need to be formatted like this to specify yorkie: terrier/yorkshire.

          Searches for a random dog pic are saved to the /searches endpoint for future reference.
        
+ Parameters
    + type: `corgi` (, optional) - type of dog

+ Request returns a pic and saves the search with specifiers
**GET**&nbsp;&nbsp;`/api/v1/dog_pics/random?type=corgi`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "image_url": "https://images.dog.ceo/breeds/corgi-cardigan/n02113186_6499.jpg",
              "name": "Supah Bat XI"
            }

+ Request returns a pic and saves the search without specifiers
**GET**&nbsp;&nbsp;`/api/v1/dog_pics/random`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "image_url": "https://images.dog.ceo/breeds/springer-english/n02102040_1976.jpg",
              "name": "Bolt Thirteen"
            }

+ Request errors for nonexistant pics and does not save the search
**GET**&nbsp;&nbsp;`/api/v1/dog_pics/random?type=coOrgi`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 404

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "furEverFinder couldn't find a pic."
            }

## Searches [/api/v1/searches]


### Create a search [POST /api/v1/searches]
Want to save more searches than searches of dog pics? This route enables you to create a search record. You are welcome to include a topic, or you can just use the default topic: misc.

+ Request creates a search record
**POST**&nbsp;&nbsp;`/api/v1/searches`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

    + Body

            search[url]=https%3A%2F%2Fmatthewrayfield.com%2Fgoodies%2Finspect-this-snake%2F&search[topic]=Games

+ Response 201

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "data": {
                "id": "3",
                "type": "search",
                "attributes": {
                  "topic": "games",
                  "url": "https://matthewrayfield.com/goodies/inspect-this-snake/",
                  "created_at": "2019-11-12T07:37:43.497Z",
                  "updated_at": "2019-11-12T07:37:43.497Z"
                }
              }
            }

+ Request returns an error for failing validations
**POST**&nbsp;&nbsp;`/api/v1/searches`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

    + Body

            search[url]=https%3A%2F%2Fmatthewrayfield.com%2Fgoodies%2Finspect-this-snake%2F

+ Response 400

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Mysterious validation error: it's possible this search url may already be saved."
            }

### Delete a search [DELETE /api/v1/searches/{id}]
Didn't want to actually save that search? No worries! This route enables you to delete a search.
+ Parameters
    + id: `6` (number, required)

+ Request deletes a search
**DELETE**&nbsp;&nbsp;`/api/v1/searches/6`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 204

    + Headers

            Accept: application/json

+ Request returns a 404 if requesting to delete an unfound search
**DELETE**&nbsp;&nbsp;`/api/v1/searches/999`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 404

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Record not found."
            }

### Get an index of searches [GET /api/v1/searches]
This route gets all the searches. If you like, you can filter the results by topic, order them by creation, or sort them by topic.

+ Request returns searches
**GET**&nbsp;&nbsp;`/api/v1/searches`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "data": [
                {
                  "id": "7",
                  "type": "search",
                  "attributes": {
                    "topic": "ancient_search",
                    "url": "http://https://www.mysterious-url.com/Vision - X-Ray",
                    "created_at": "2019-11-07T07:37:43.533Z",
                    "updated_at": "2019-11-07T07:37:43.533Z"
                  }
                },
                {
                  "id": "8",
                  "type": "search",
                  "attributes": {
                    "topic": "finn",
                    "url": "http://https://www.mysterious-url.com/Anti-Gravity",
                    "created_at": "2019-11-08T07:37:43.537Z",
                    "updated_at": "2019-11-08T07:37:43.537Z"
                  }
                },
                {
                  "id": "9",
                  "type": "search",
                  "attributes": {
                    "topic": "jake",
                    "url": "http://https://www.mysterious-url.com/Phasing",
                    "created_at": "2019-11-09T07:37:43.573Z",
                    "updated_at": "2019-11-09T07:37:43.573Z"
                  }
                },
                {
                  "id": "10",
                  "type": "search",
                  "attributes": {
                    "topic": "finn",
                    "url": "http://https://www.mysterious-url.com/Cryokinesis",
                    "created_at": "2019-11-10T07:37:43.580Z",
                    "updated_at": "2019-11-10T07:37:43.580Z"
                  }
                },
                {
                  "id": "11",
                  "type": "search",
                  "attributes": {
                    "topic": "jake",
                    "url": "http://https://www.mysterious-url.com/Danger Sense",
                    "created_at": "2019-11-11T07:37:43.583Z",
                    "updated_at": "2019-11-11T07:37:43.583Z"
                  }
                },
                {
                  "id": "12",
                  "type": "search",
                  "attributes": {
                    "topic": "newest_search_ever",
                    "url": "http://https://www.mysterious-url.com/Enhanced Memory",
                    "created_at": "2019-11-12T07:37:43.615Z",
                    "updated_at": "2019-11-12T07:37:43.615Z"
                  }
                }
              ]
            }

+ Request returns searches ordering by newist
**GET**&nbsp;&nbsp;`/api/v1/searches?ordered_by=newist_created`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "data": [
                {
                  "id": "12",
                  "type": "search",
                  "attributes": {
                    "topic": "newest_search_ever",
                    "url": "http://https://www.mysterious-url.com/Enhanced Memory",
                    "created_at": "2019-11-12T07:37:43.615Z",
                    "updated_at": "2019-11-12T07:37:43.615Z"
                  }
                },
                {
                  "id": "11",
                  "type": "search",
                  "attributes": {
                    "topic": "jake",
                    "url": "http://https://www.mysterious-url.com/Danger Sense",
                    "created_at": "2019-11-11T07:37:43.583Z",
                    "updated_at": "2019-11-11T07:37:43.583Z"
                  }
                },
                {
                  "id": "10",
                  "type": "search",
                  "attributes": {
                    "topic": "finn",
                    "url": "http://https://www.mysterious-url.com/Cryokinesis",
                    "created_at": "2019-11-10T07:37:43.580Z",
                    "updated_at": "2019-11-10T07:37:43.580Z"
                  }
                },
                {
                  "id": "9",
                  "type": "search",
                  "attributes": {
                    "topic": "jake",
                    "url": "http://https://www.mysterious-url.com/Phasing",
                    "created_at": "2019-11-09T07:37:43.573Z",
                    "updated_at": "2019-11-09T07:37:43.573Z"
                  }
                },
                {
                  "id": "8",
                  "type": "search",
                  "attributes": {
                    "topic": "finn",
                    "url": "http://https://www.mysterious-url.com/Anti-Gravity",
                    "created_at": "2019-11-08T07:37:43.537Z",
                    "updated_at": "2019-11-08T07:37:43.537Z"
                  }
                },
                {
                  "id": "7",
                  "type": "search",
                  "attributes": {
                    "topic": "ancient_search",
                    "url": "http://https://www.mysterious-url.com/Vision - X-Ray",
                    "created_at": "2019-11-07T07:37:43.533Z",
                    "updated_at": "2019-11-07T07:37:43.533Z"
                  }
                }
              ]
            }

+ Request returns searches ordering by oldest
**GET**&nbsp;&nbsp;`/api/v1/searches?ordered_by=oldest_created`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "data": [
                {
                  "id": "7",
                  "type": "search",
                  "attributes": {
                    "topic": "ancient_search",
                    "url": "http://https://www.mysterious-url.com/Vision - X-Ray",
                    "created_at": "2019-11-07T07:37:43.533Z",
                    "updated_at": "2019-11-07T07:37:43.533Z"
                  }
                },
                {
                  "id": "8",
                  "type": "search",
                  "attributes": {
                    "topic": "finn",
                    "url": "http://https://www.mysterious-url.com/Anti-Gravity",
                    "created_at": "2019-11-08T07:37:43.537Z",
                    "updated_at": "2019-11-08T07:37:43.537Z"
                  }
                },
                {
                  "id": "9",
                  "type": "search",
                  "attributes": {
                    "topic": "jake",
                    "url": "http://https://www.mysterious-url.com/Phasing",
                    "created_at": "2019-11-09T07:37:43.573Z",
                    "updated_at": "2019-11-09T07:37:43.573Z"
                  }
                },
                {
                  "id": "10",
                  "type": "search",
                  "attributes": {
                    "topic": "finn",
                    "url": "http://https://www.mysterious-url.com/Cryokinesis",
                    "created_at": "2019-11-10T07:37:43.580Z",
                    "updated_at": "2019-11-10T07:37:43.580Z"
                  }
                },
                {
                  "id": "11",
                  "type": "search",
                  "attributes": {
                    "topic": "jake",
                    "url": "http://https://www.mysterious-url.com/Danger Sense",
                    "created_at": "2019-11-11T07:37:43.583Z",
                    "updated_at": "2019-11-11T07:37:43.583Z"
                  }
                },
                {
                  "id": "12",
                  "type": "search",
                  "attributes": {
                    "topic": "newest_search_ever",
                    "url": "http://https://www.mysterious-url.com/Enhanced Memory",
                    "created_at": "2019-11-12T07:37:43.615Z",
                    "updated_at": "2019-11-12T07:37:43.615Z"
                  }
                }
              ]
            }

+ Request returns searches sorted by topic
**GET**&nbsp;&nbsp;`/api/v1/searches?sorted_by_topic=true`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "data": [
                {
                  "id": "7",
                  "type": "search",
                  "attributes": {
                    "topic": "ancient_search",
                    "url": "http://https://www.mysterious-url.com/Vision - X-Ray",
                    "created_at": "2019-11-07T07:37:43.533Z",
                    "updated_at": "2019-11-07T07:37:43.533Z"
                  }
                },
                {
                  "id": "8",
                  "type": "search",
                  "attributes": {
                    "topic": "finn",
                    "url": "http://https://www.mysterious-url.com/Anti-Gravity",
                    "created_at": "2019-11-08T07:37:43.537Z",
                    "updated_at": "2019-11-08T07:37:43.537Z"
                  }
                },
                {
                  "id": "10",
                  "type": "search",
                  "attributes": {
                    "topic": "finn",
                    "url": "http://https://www.mysterious-url.com/Cryokinesis",
                    "created_at": "2019-11-10T07:37:43.580Z",
                    "updated_at": "2019-11-10T07:37:43.580Z"
                  }
                },
                {
                  "id": "9",
                  "type": "search",
                  "attributes": {
                    "topic": "jake",
                    "url": "http://https://www.mysterious-url.com/Phasing",
                    "created_at": "2019-11-09T07:37:43.573Z",
                    "updated_at": "2019-11-09T07:37:43.573Z"
                  }
                },
                {
                  "id": "11",
                  "type": "search",
                  "attributes": {
                    "topic": "jake",
                    "url": "http://https://www.mysterious-url.com/Danger Sense",
                    "created_at": "2019-11-11T07:37:43.583Z",
                    "updated_at": "2019-11-11T07:37:43.583Z"
                  }
                },
                {
                  "id": "12",
                  "type": "search",
                  "attributes": {
                    "topic": "newest_search_ever",
                    "url": "http://https://www.mysterious-url.com/Enhanced Memory",
                    "created_at": "2019-11-12T07:37:43.615Z",
                    "updated_at": "2019-11-12T07:37:43.615Z"
                  }
                }
              ]
            }

+ Request returns searches filtered by topic
**GET**&nbsp;&nbsp;`/api/v1/searches?topic=finn`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "data": [
                {
                  "id": "8",
                  "type": "search",
                  "attributes": {
                    "topic": "finn",
                    "url": "http://https://www.mysterious-url.com/Anti-Gravity",
                    "created_at": "2019-11-08T07:37:43.537Z",
                    "updated_at": "2019-11-08T07:37:43.537Z"
                  }
                },
                {
                  "id": "10",
                  "type": "search",
                  "attributes": {
                    "topic": "finn",
                    "url": "http://https://www.mysterious-url.com/Cryokinesis",
                    "created_at": "2019-11-10T07:37:43.580Z",
                    "updated_at": "2019-11-10T07:37:43.580Z"
                  }
                }
              ]
            }

+ Request errors for invalid param keys
**GET**&nbsp;&nbsp;`/api/v1/searches?skydiver=newist`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 400

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Invalid query parameter(s): skydiver. Please verify the query parameter name(s)."
            }

+ Request errors for currently unsupported param combinations
**GET**&nbsp;&nbsp;`/api/v1/searches?ordered_by=newist_created&sorted_by_topic=true`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 400

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Query parameter combo is currently unsupported: ordered_by and sorted_by_topic."
            }

+ Request errors for an invalid ordered_by param value
**GET**&nbsp;&nbsp;`/api/v1/searches?ordered_by=avocado`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 422

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Unpermitted value for ordered_by: avocado. Please verify the query parameter value(s)."
            }

+ Request errors for an invalid sorted_by_topic param value
**GET**&nbsp;&nbsp;`/api/v1/searches?sorted_by_topic=avocado`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 422

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Unpermitted value for sorted_by_topic: avocado. Please verify the query parameter value(s)."
            }

+ Request returns an empty array if no searches exist
**GET**&nbsp;&nbsp;`/api/v1/searches`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "data": [
            
              ]
            }

+ Request errors for an invalid param key
**GET**&nbsp;&nbsp;`/api/v1/searches?galapagos=oldest&ordered_by=oldest`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 400

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Invalid query parameter(s): galapagos. Please verify the query parameter name(s)."
            }

+ Request errors for invalid param keys
**GET**&nbsp;&nbsp;`/api/v1/searches?kiwi=newist&mango=newist&melon=newist&ordered_by=`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 400

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Invalid query parameter(s): kiwi, mango, and melon. Please verify the query parameter name(s)."
            }

+ Request errors for an unsupported param combo
**GET**&nbsp;&nbsp;`/api/v1/searches?ordered_by=newist_created&sorted_by_topic=true`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 400

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Query parameter combo is currently unsupported: ordered_by and sorted_by_topic."
            }

+ Request errors for an invalid ordered_by param value
**GET**&nbsp;&nbsp;`/api/v1/searches?ordered_by=avocado`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 422

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Unpermitted value for ordered_by: avocado. Please verify the query parameter value(s)."
            }

+ Request errors for an invalid sorted_by_topic param value
**GET**&nbsp;&nbsp;`/api/v1/searches?sorted_by_topic=avocado`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 422

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Unpermitted value for sorted_by_topic: avocado. Please verify the query parameter value(s)."
            }

### Get a search by id [GET /api/v1/searches/{id}]
This route retrieves a search by its id.
+ Parameters
    + id: `13` (number, required)

+ Request sends a single search
**GET**&nbsp;&nbsp;`/api/v1/searches/13`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "data": {
                "id": "13",
                "type": "search",
                "attributes": {
                  "topic": "misc",
                  "url": "http://https://www.mysterious-url.com/Energy Armor",
                  "created_at": "2019-11-12T07:37:43.751Z",
                  "updated_at": "2019-11-12T07:37:43.751Z"
                }
              }
            }

+ Request returns a 404 when a search is not found
**GET**&nbsp;&nbsp;`/api/v1/searches/999`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 404

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Record not found."
            }

### Update the topic of a search [PATCH /api/v1/searches/{id}]
This route enables you to update the topic of a search. Currently, no other fields are updatable.
+ Parameters
    + id: `14` (number, required)

+ Request updates a search record
**PATCH**&nbsp;&nbsp;`/api/v1/searches/14`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

    + Body

            search[topic]=skydiving_penguins

+ Response 200

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "data": {
                "id": "14",
                "type": "search",
                "attributes": {
                  "topic": "skydiving_penguins",
                  "url": "http://https://www.mysterious-url.com/Enhanced Hearing",
                  "created_at": "2019-11-12T07:37:43.764Z",
                  "updated_at": "2019-11-12T07:37:43.768Z"
                }
              }
            }

+ Request returns a 404 if requesting to update an unfound search
**PATCH**&nbsp;&nbsp;`/api/v1/searches/999`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

    + Body

            search[topic]=kayaking_giraffes

+ Response 404

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Record not found."
            }

+ Request returns an invalid payload error for empty payloads
**PATCH**&nbsp;&nbsp;`/api/v1/searches/15`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Invalid payload: param is missing or the value is empty: search."
            }

+ Request returns an invalid param error for invalid payloads
**PATCH**&nbsp;&nbsp;`/api/v1/searches/16`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

    + Body

            search[url]=www.cat-facts.com

+ Response 400

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "error": "Invalid query parameter(s): url. Please verify the query parameter name(s)."
            }
