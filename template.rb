# See https://guides.rubyonrails.org/generators.html#application-templates

git :init
git add: "."
git commit: "-a -m 'Initial commit'"

gem_group :development, :test do

  # Use RSpec for unittests instead of minitest. Minitest is like driving a
  # Formula 1 car. Whereas RSpec has quality of life improvements to feel
  # like driving a Ferrari.
  gem "rspec-rails"

  # A library for generating fake data such as names, addresses, and phone numbers.
  # https://github.com/faker-ruby/faker
  gem "faker"

  # Fixtures replacement with a straightforward definition syntax
  # This will cause Rails to generate factories instead of fixtures.
  # https://github.com/thoughtbot/factory_bot_rails/
  gem "factory_bot_rails"

  # Brakeman is a security scanner for Ruby on Rails applications.
  # https://brakemanscanner.org/docs/introduction/
  gem "brakeman"

  # Standardize Ruby formatting https://github.com/testdouble/standard.
  # Prefer a simpler set of ruby linting rules that are easy to follow.
  gem "standard"
end

# Generate needed boilerplate rspec configuration files
rails_command "generate rspec:install"

# Delete minitest specific test/ folder since we're using rspec's spec/ folder
run "rm -rf test/"

# Create factory bot configuration file
create_file "spec/support/factory_bot.rb", <<~EOF
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
EOF

# Use Github Actions for CI as a default. This creates 3 jobs:
# One to run the unittest suite, the brakeman security scanner,
# and the standardrb Ruby linter. Feel free to add more jobs.
create_file ".github/workflows/default_workflow.yml", <<~EOF
name: Continuous Integration
on: [push, pull_request]
jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: ruby/setup-ruby@v1
      with:
        bundler-cache: true # runs 'bundle install' and caches installed gems automatically
    - run: bundle exec rspec
  security:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: ruby/setup-ruby@v1
      with:
        bundler-cache: true
    - run: bundle exec brakeman
  lint:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: ruby/setup-ruby@v1
      with:
        bundler-cache: true
    - run: bundle exec standardrb
EOF

# Add linux platform to Gemfile.lock to handle linux containers within
# Github Actions
run "bundle lock --add-platform x86_64-linux"

# [OPTIONAL] Add arm64 to Gemfile.lock for M1 apple silicon macs.
run "bundle lock --add-platform arm64-darwin-21"

# Auto fix common formatting violations of a greenfield Rails app
run "bundle exec standardrb --fix"

after_bundle do
  git add: '.'
  git commit: "-a -m 'Generate binstubs and lint Ruby'"

  say <<-EOS

============================================================================
Your app is now available.
EOS
end
