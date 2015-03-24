source 'https://rubygems.org'

ruby "2.2.1"

gem 'dotenv-rails', require: 'dotenv/rails-now', groups: [:development, :test]

gem 'rails', '~> 4.1.2'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'devise'
gem 'newrelic_rpm'
gem "skylight"

group :development,:test do
  gem 'sqlite3'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :production do
  gem 'heroku_rails_deflate'
  gem 'rails_12factor'
  gem 'unicorn'
  gem 'pg'
end

gem 'flipkart', '~> 0.0.3'

gem 'bugsnag'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'sucker_punch', '~> 1.0'
gem 'mixpanel-ruby'

gem 'sass-rails', '~> 4.0.0'
gem 'haml'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  gem 'webmock'
  gem 'vcr'
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem "rspec-rails"
  gem "faker"
  gem "launchy"
  gem 'rb-inotify'
  gem 'libnotify'
  gem 'rb-readline'
end
