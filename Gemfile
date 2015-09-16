source 'https://rubygems.org'
ruby '2.2.0'

gem 'bootstrap-sass', '3.1.1.1'
gem 'coffee-rails'
gem 'rails', '4.2.4'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'bootstrap_form'
gem 'bcrypt'
gem 'sidekiq'
gem 'sinatra'
gem 'slim'
gem 'eventmachine', github: "eventmachine/eventmachine"
gem 'sentry-raven'
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'mini_magick'

group :development do
  gem 'thin'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '3.1'
  gem 'fabrication'
  gem 'faker'
  gem 'capybara'
  gem 'capybara-email'
end

group :test do
  gem 'database_cleaner', '1.2.0'
  gem 'shoulda-matchers'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
  gem 'puma'
end
