source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'

# Use postgresql as the database for Active Record
# gem 'pg'
# active record removed as below
# . Remove database adapter gems from your Gemfile (mysql2, sqlite3, etc.)
#
# 2. Change your config/application.rb
#
# Remove require 'rails/all line and require frameworks you want to use, for example:
#
# require "action_controller/railtie"
# require "action_mailer/railtie"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"
# 3. Delete your config/database.yml file, db/schema.rb and migrations (if any)
#
# 4. Delete migration check in test/test_helper.rb
#
# 5. Delete any ActiveRecord configuration from your config/environments files (this is what is causing your error)


# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
#gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'jasmine-rails'
  gem 'annotate', '2.5.0'
  gem "intellij-coffee-script-debugger", :git => "git://github.com/JetBrains/intellij-coffee-script-debugger.git"
end

group :test do
  #gem 'cucumber-rails',">= 1.3.8", :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'capybara' , '2.2.0'
  gem 'capybara-webkit', '~> 1.0.0'
  gem 'factory_girl_rails', '4.1.0'
  gem 'launchy'
end

gem 'haml-rails'
gem 'angular-rails-templates'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
