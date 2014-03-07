source 'https://rubygems.org'

ruby '2.1.1'
gem 'rails', '4.0.3'
gem 'pg'

gem 'bitcoin-ruby', git: 'https://github.com/lian/bitcoin-ruby',
                    branch: 'master', require: 'bitcoin'
gem 'coffee-rails', '~> 4.0.0'
gem 'devise'
gem 'ffi'
gem 'foundation-rails'
gem 'griddler'
gem 'haml'
gem 'httparty'
gem 'jquery-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn'

group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'factory_girl'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :production do
  gem 'rails_12factor'
end
