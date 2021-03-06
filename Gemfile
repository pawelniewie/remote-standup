source 'https://rubygems.org'
ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.2'

# Analytics
gem 'rack-google-analytics'
gem 'intercom-rails', '~> 0.2.24'

# Authentication
gem 'devise'
gem 'devise-encryptable'
gem 'devise_invitable'
gem 'omniauth-google-oauth2'
gem 'omniauth-bitbucket'
gem 'omniauth-github'
gem 'omniauth-asana'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem 'omniauth-twitter'
gem 'koala'
gem 'gravtastic'

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
gem 'jquery-rails'

gem 'haml-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Logging to stdout by default
gem 'rails_stdout_logging'

# Mails
gem 'gibbon'
gem 'mandrill-api', :require => "mandrill"
gem 'mandrill-rails'
gem 'sidekiq'
gem 'sidetiq'
gem 'email_reply_parser', github: 'raymccoy/email_reply_parser', branch: 'improved-sig-parsing'
gem 'vpim-rails'

# Data pulling
gem 'mixpanel_client'
gem 'intercom'

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
	gem 'erb2haml'

	gem 'shoulda'
	gem 'email_spec'

	gem 'spork', '~> 1.0rc'
	gem 'factory_girl_rails'
	gem 'database_cleaner'
	gem 'capybara'
	gem 'capybara-screenshot'
	gem 'site_prism'
	gem 'rspec-rails'
	gem 'selenium-webdriver'
	gem "rack_session_access"

	gem 'capistrano'
	gem 'capistrano-rails'
	gem 'capistrano-bundler'
	gem 'capistrano-bower'
end

# Use unicorn as the app server
gem 'unicorn'
