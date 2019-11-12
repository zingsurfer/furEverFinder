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
