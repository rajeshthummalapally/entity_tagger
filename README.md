# EntityTagger

Ruby version: ruby 2.2.1p85

## Setting up locally
After cloning and doing a bundle install, install PostgreSQL with homebrew
```bash
brew install postgresql
```

You'll need to create the mvp user with password 'secret' like so
```bash
psql -u root -p
psql> CREATE USER 'mvp'@'localhost' IDENTIFIED BY 'secret';
psql> GRANT ALL PRIVILEGES ON * . * TO 'mvp'@'localhost';
psql> quit
```

Before testing the apis, run
```bash
rake db:create db:migrate
```

You can run specs using
```bash
rake spec
```

## Notes:
Any model specified by the constraints in the routes can be tagged. As such, Taggings are polymorphic.
I chose to use a service object for handling all the business logic to create entities and tags.
That way, the controller doesn't know anything about it and can be easily maintainable.
I did not use FactoryGirl or fixtures since the existing no. of attributes on the models are small.

Requirements.md asks 'GET /stats/:entity_type/:entity_id' to 'Retrives statistics about a specific tagged entity'. 
I could be missing something, but Other than tags, are there any other stats?
Since the stats of a specific entity can be accessed using 'GET /tags/:entity_type/:entity_id', 
I changed the url to 'stats/tags/:tag_id' to return stats about a tag.

