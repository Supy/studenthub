source 'https://rubygems.org'

# explicet ruby version
ruby '2.1.2'

# rails version
gem 'rails', '4.1.4'

# databases
gem 'mysql2', group: :production
gem 'sqlite3', group: [:development, :test]

# html/javascript/css preprocessors
gem 'haml-rails', '~> 0.5.3'
gem 'sass-rails', '~> 4.0.3'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'

# deployment
group :development, :test do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'

  gem 'rspec-rails', '~> 3.0.0'   # Rspec runs our unit tests
  gem 'simplecov', require: false
end

# javascript runtime
gem 'therubyracer',  platforms: :ruby

# jquery!
gem 'jquery-rails', '~> 3.1.1'

# tree library
gem 'closure_tree', '~> 5.0.0'
