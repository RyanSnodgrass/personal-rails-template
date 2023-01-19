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

  # Standardize ruby formatting https://github.com/testdouble/standard.
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

# Auto fix common formatting violations of a greenfield rails app
run "bundle exec standardrb --fix"

after_bundle do
  git add: '.'
  git commit: "-a -m 'Generate binstubs, lint ruby'"
end

say <<-EOS
  ============================================================================
  Your app is now available.
EOS
