source 'https://rubygems.org'
ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.2'

# Google Analytics
gem 'rack-google-analytics'

# Authentication
gem 'devise'
gem 'devise-encryptable'
gem 'devise_invitable'
gem 'omniauth-google-oauth2'
gem 'omniauth-bitbucket'
gem 'omniauth-github'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem 'omniauth-twitter'
gem 'koala'

# Database
gem 'pg'

# Smart ENV management
gem 'figaro'

# Assets
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'asset_sync'
gem 'unf'

gem 'angularjs-rails'
gem 'angular-ui-bootstrap-rails'
gem 'less-rails'
gem 'bootstrap-sass', '~> 3.1.0.0'
gem 'font-awesome-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Logging to stdout by default
gem 'rails_stdout_logging'

# Mails
gem 'gibbon'
gem 'intercom-rails', '~> 0.2.24'
gem 'mandrill-api', :require => "mandrill"
gem 'mandrill-rails'
gem 'mandrill_mailer'
gem 'sidekiq'
gem 'sidetiq'
gem 'email_reply_parser', github: 'raymccoy/email_reply_parser', branch: 'improved-sig-parsing'

# Views
gem 'haml-rails'

gem 'detect_timezone_rails'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
	# Monitoring
	gem 'newrelic_rpm'

	# Better heroku support (serving static files and logging to stdout)
	gem 'rails_12factor'
end

group :development, :test do
	gem 'minitest'
	gem 'capybara'
	gem 'rspec-rails'
	gem 'erb2haml'

	gem 'capistrano'
	gem 'capistrano-rails'
	gem 'capistrano-bundler'
	gem 'capistrano-bower'
end

# Use unicorn as the app server
gem 'unicorn'
