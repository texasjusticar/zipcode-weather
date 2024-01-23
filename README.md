# Temperature Forecast

This application utilizes the Tomorrow.io free weather api.  To use locally you will need an api key: https://app.tomorrow.io/signup

* I tried to limit dependencies so there is no database, and caching is handled with file_store
* You will need a .env file with your api key.  Provided is an example .env_example file in hte root, just rename to .env and populate with your api key
* `bundle install`
* `bundle exec rails s` to run server.  Use web browser to go to localhost:3000
* To run tests - `bundle exec rspec`
