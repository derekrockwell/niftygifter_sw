source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'thin'

gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails'
gem 'jquery-ui-rails'
gem 'jquery_mobile_rails'
gem 'font-awesome-rails'
gem 'figaro'
gem "omniauth-facebook"
gem "koala"
gem 'devise'
gem 'execjs'
gem 'bundler'
gem 'activeadmin'
gem "permanent_records"
gem 'amazon-ecs'

gem 'twilio-ruby'
gem 'browser'

group :production do 
	gem 'newrelic_rpm'
	gem 'pg'	
end

group :test, :development do
	gem "factory_girl_rails", :require => false
	gem "rspec-rails"
	gem "rspec_junit_formatter"
	gem "capybara"
	gem "guard-rspec"
	gem "spork-rails"
	gem "simplecov"
	gem "database_cleaner"
	gem "faker"
	gem 'sqlite3'
	gem 'therubyracer', :platform => :ruby	
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem 'sass-rails',   '~> 3.2.3'
	gem 'coffee-rails', '~> 3.2.1'
	gem 'uglifier', '>= 1.0.3'
end


