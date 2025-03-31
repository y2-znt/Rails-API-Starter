source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# Use pg as the database for Active Record
gem "pg"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors"

# JSON Web Token implementation
gem "jwt"

# Use ActiveModelSerializers for JSON serialization [https://github.com/rails-api/active_model_serializers]
gem "active_model_serializers", "~> 0.10.0"

# Authorization library for Ruby on Rails [https://github.com/varvet/pundit]
gem "pundit", "~> 2.5"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Annotate Rails models with their associations [https://github.com/drwl/annotaterb]
  gem "annotaterb"

  # Add Factory Bot Rails for test data generation [https://github.com/thoughtbot/factory_bot_rails]
  gem "factory_bot_rails"

  # Add Shoulda Matchers for testing validations and associations [https://github.com/thoughtbot/shoulda-matchers]
  gem "shoulda-matchers", "~> 6.4"

  # Add Shoulda Context for testing contexts [https://github.com/thoughtbot/shoulda-context]
  gem "shoulda-context"
end
