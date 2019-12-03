# furEverFinder
<img src="https://user-images.githubusercontent.com/36902512/68681815-510baa00-0521-11ea-8e07-802e91c3b2db.jpg" alt="jamie-street-XyGq7VvgUhM-unsplash" height="400"/>

### Intro
furEverFinder is an API for saving and fetching your searches!

furEverFinder endeavors to save your searches so that finds for the same search query will be more accessible the next time you search. furEverFinder features CRUD functionality if you would like to, say, save a search for skydiving penguins.

If your looking for ideas, furEverFinder also consumes the [Dog CEO API](https://github.com/ElliottLandsborough/dog-ceo-api) (a random dog pic generator that enables you to specify a type of dog if you like). After searching for a random dog pic at `/api/v1/dog_pics/random`, head over to `/api/v1/searches`. If there's a dog and the search is unique, you will see it added to the list.

Welcome to the GitHub repo! If you'd like to take a look at the app in all its deployed glory, check this out: https://fur-ever-finder.herokuapp.com/. Ideas & feedback are welcome.

#### Stack
Rails 5.2.3, Ruby 2.5.1, RSpec, PostgreSQL, [Dox](https://github.com/infinum/dox) & [Aglio](https://github.com/danielgtaylor/aglio) (for living documentation), [FactoryBot](https://github.com/thoughtbot/factory_bot), [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers), [DatabaseCleaner](https://github.com/DatabaseCleaner/database_cleaner), [FastJSON API](https://github.com/Netflix/fast_jsonapi), [Faraday](https://github.com/lostisland/faraday)

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
- Heroku site: https://fur-ever-finder.herokuapp.com/
- Project kanban: https://github.com/Autumn-Martin/furEverFinder/projects/1
- Searches: https://fur-ever-finder.herokuapp.com/api/v1/searches
- Random dog pic: https://fur-ever-finder.herokuapp.com/api/v1/dog_pics/random

## Endpoints

## Random dog pic with a heroic name
### GET **/api/v1/dog_pics/random**
**Optional params:**
`type={type_of_dog}`

**required headers:**
none

**Description:**
This route retrieves a random dog pic & pairs it with a heroes name. If you like, you can specify what type of dog you would like to see. If it is available, furEverFinder will find it for you. Some types, like yorkshire terrier, may need to be formatted like this to specify yorkie: terrier/yorkshire.

Searches for a random dog pic are saved to the /searches endpoint for future reference.

**Example:**

Request:
```
GET /api/v1/dog_pics?type=husky
```

Response:
```
status: 200
headers: {
  Content-Type: application/json
  Accept: application/json
}
body: {
  "image_url": "https://images.dog.ceo/breeds/husky/n02110185_14283.jpg",
  "name": "Jack of Hearts"
}
```

## Get a list of searches
### GET **/api/v1/searches**
**Optional params:**
`topic={topic_to_filter_by}`, `ordered_by=newist_created`, `ordered_by=oldest_created`, `sorted_by_topic=true`

**Request headers:**
none

**Description:**
This route gets all the searches. If you like, you can filter the results by topic, order them by creation, or sort them by topic.

**Example:**

Request:
```
GET /api/v1/searches
```

Response:
```
status: 200
headers: {
  Content-Type: application/json
  Accept: application/json
}
body: {
  "data": [
    {
      "id": "1",
      "type": "search",
      "attributes": {
        "topic": "misc",
        "url": "www.ultrarunning-turtles.com",
        "created_at": "2019-11-11T05:08:09.332Z",
        "updated_at": "2019-11-11T05:08:09.332Z"
      }
    },
    {
      "id": "7",
      "type": "search",
      "attributes": {
        "topic": "misc",
        "url": "www.seafaring-giraffes.com",
        "created_at": "2019-11-11T05:16:16.386Z",
        "updated_at": "2019-11-11T05:16:16.386Z"
      }
    }
  ]
}
```

## Get a search by id
### GET **/api/v1/searches/:id**
**Optional params:**
none

**Request headers:**
none

**Description:**
This route retrieves a search by its id.

**Example:**

Request:
```
GET /api/v1/searches/7
```

Response:
```
status: 200
headers: {
  Content-Type: application/json
  Accept: application/json
}
body: {
  "data": [
    {
      "id": "7",
      "type": "search",
      "attributes": {
        "topic": "misc",
        "url": "www.seafaring-giraffes.com",
        "created_at": "2019-11-11T05:16:16.386Z",
        "updated_at": "2019-11-11T05:16:16.386Z"
      }
    }
  ]
}
```

## Update the topic for a search
### PATCH **/api/v1/searches/:id**
**Optional params:**
none

**Request headers:**
Content-Type: application/json
Accept: application/json

**Description:**
This route updates the topic of a search (currently the only allowed value to be updated).

**Example:**

Request:
```
PATCH /api/v1/searches/7
headers: {
  Content-Type: application/json
  Accept: application/json
}
body: {
	"search": { "topic": "giraffes" }
}
```

Response:
```
status: 200
headers: {
  Content-Type: application/json
  Accept: application/json
}
body: {
  "data": [
    {
      "id": "7",
      "type": "search",
      "attributes": {
        "topic": "giraffes",
        "url": "www.seafaring-giraffes.com",
        "created_at": "2019-11-11T05:16:16.386Z",
        "updated_at": "2019-11-11T05:16:16.386Z"
      }
    }
  ]
}
```

## Create a search
### POST **/api/v1/searches**

**Request headers:**
Content-Type: application/json
Accept: application/json

**Description:**
This route creates a search. Topic defaults to `misc` if it's not explicitly stated.

**Example:**

Request:
```
POST /api/v1/searches
headers: {
  Content-Type: application/json
  Accept: application/json
}
body: {
  search: {
    "url": "www.cats-r-cool-too.com"
  }
}
```

Response:
```
status: 201
headers: {
  Content-Type: application/json
  Accept: application/json
}
body: {
  "data":  {
    "id": "1",
    "type": "search",
    "attributes": {
      "topic": "misc",
      "url": "www.cats-r-cool-too.com",
      "created_at": "2019-11-11T05:08:09.332Z",
      "updated_at": "2019-11-11T05:08:09.332Z"
    }
  }
}
```

## Delete a search
### DELETE **/api/v1/searches/:id**
**Optional params:**
none

**Request headers:**
none

**Description:**
This route deletes a search.

**Example:**

Request:
```
DELETE /api/v1/searches/7
```

Response:
```
status: 204
headers: {
  Content-Type: application/json
  Accept: application/json
}
```

## Getting started

### Production
This app is deployed Heroku. It may be viewed in production here: https://fur-ever-finder.herokuapp.com/

### Development
First, clone this repository via `git clone git@github.com:Autumn-Martin/furEverFinder.git`.

Install the all the gems using [Bundler](http://bundler.io/). Run `bundle` in the CLI.

Run `rake db:create && rake db:schema:load` to create the database, and build tables and columns based on the schema for the first time.

Start a server with `rails s`, and visit `http://localhost:3000/`.

### Testing

The test suite is created through RSpec. To run this test suite, run `rspec`. Currently, this repo maintains 100% test coverage. This can be viewed directly if you open the index file, furEverFinder/coverage/index.html, in a browser. 

<img width="1192" alt="Screen Shot 2019-11-12 at 7 57 09 AM" src="https://user-images.githubusercontent.com/36902512/68682353-3d147800-0522-11ea-9cbf-eedf869000b1.png">
