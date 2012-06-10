source 'https://rubygems.org'

gem 'rails', '3.2.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
	gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
end

gem 'jquery-rails'

gem 'bcrypt-ruby', '~> 3.0.0'
gem 'cancan'

gem 'jbuilder'

gem 'will_paginate', '~> 3.0'

gem 'http_accept_language'

gem 'rspec-rails', :group => [:test, :development]

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'factory_girl_rails'
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'database_cleaner'

  # Required by travis-ci
  gem 'rake'
end

gem 'simple_form'