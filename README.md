# TDD with Rspec and Ruby on Rails
This is a repo with an exemplo of the TDD approach with Ruby on Rails, RSpec and Capybara.

## Prerequisites
You have to first install Ruby 2+ and have bundle installed in you machine. You have to install nodejs too. Before run the application and the tests, migrate the database with the following command:

```bin/rails db:migrate RAILS_ENV=development```

## Running the tests

```bin/rspec spec/features```

## Running the web application

```rails s -b 0.0.0.0```
