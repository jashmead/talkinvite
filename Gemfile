# Gemfile for project Mencken Tarot 'mt'

source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use Postgres as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# switch to bootstrap, rspec, factory_girl, selenium, capybara
# bootstrap css
gem 'bootstrap-sass'            # need to comment out before move to jQuery Mobile? there may be something still depending on it
# gem 'bootstrap-sass-rails'    # no apparent benefit, inspite of greater specificity
# gem 'bootstrap-will_paginate' # fix up will_paginate stuff to match bootstrap, produced no apparent improvement
# gem 'will_paginate-bootstrap' # this gem didn't make any difference either...

## load capybara before rspec
## how does capybara drive the web? via Rack::Test & Selenium
group :development, :test do
  gem 'selenium-webdriver'
  gem 'capybara', '>= 2.0.0'
  # launchy makes available a 'save_and_open_page' command to see the page
  #   -- you have to have visited the page before you can do this!
  #   -- since launchy is being called via capybara, 
  #     -- you have to be 'inside' capybara in some sense, 
  #     i.e. using 'it' rather than 'describe'
  gem 'launchy' # lets us insert a 'save_and_open_page' line inside specs to see what the page looks like
end

# keep factory girl in development for testing at the console
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# bcrypt-ruby 3.1.0 does not work with Mac, so force backwards
gem 'bcrypt-ruby', '3.0.1'

gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

## we tried haml out, but it has a problem with nested layouts
# gem 'haml'

gem 'rdoc'

##  group :development do
##    # RedCloth is supposed to enable rake doc:guides 
##    # not working, not worth the trouble to sort out
##    gem 'RedCloth', :require => 'redcloth'
##  end

## ransack not playing nicely with the tutorial
## gem 'ransack'

## on load to heroku you will see:
##  -----> WARNINGS:
##         Include 'rails_12factor' gem to enable all platform features
##         See https://devcenter.heroku.com/articles/rails-integration-gems for more information.
## ignore this suggestion; it is a disaster
