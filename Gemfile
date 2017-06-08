source 'https://rubygems.org'

#ruby=ruby-2.2.6
#ruby-gemset=possum

gem 'rake'
gem 'rails-api'
gem 'rails', '~> 4.2'
gem 'puma'

gem 'sequel-rails'
gem 'pg'
gem 'sequel-postgres-schemata', require: false

gem 'base32-crockford'
gem 'activesupport'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'random_password_generator', '= 1.0.0'
gem 'slosilo', '>=2.0.0'
gem 'listen'
gem 'gli', require: false

# Installing ruby_dep 1.4.0
# Gem::InstallError: ruby_dep requires Ruby version >= 2.2.5, ~> 2.2.
gem 'ruby_dep', '= 1.3.1'

gem 'conjur-api', github: 'conjurinc/api-ruby', branch: 'possum'
gem 'conjur-rack', github: 'conjurinc/conjur-rack', branch: 'possum'
gem 'conjur-rack-heartbeat'
gem 'conjur-policy-parser', github: 'conjurinc/conjur-policy-parser', branch: 'possum'
gem 'rack-rewrite'

gem 'simplecov', require: false

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'conjur-debify', require: false
  gem 'spring'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
  gem 'json_spec'
  gem 'rspec'
  gem 'table_print'
  gem 'rspec-rails'
  gem 'ci_reporter_rspec'
  gem 'parallel'
  gem 'cucumber'
  gem 'aruba'
  gem 'rake_shared_context'
  gem 'conjur-cli', github: 'conjurinc/cli-ruby', branch: 'possum'
end
