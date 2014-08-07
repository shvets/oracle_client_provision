source "https://rubygems.org"

# Run "bundle install --without=oracle" to install gems without ruby-oci8 driver

group :default do
  gem "text-interpolator", "~>1.0"
  gem "script_executor", "~>1.5"
  gem "thor", "~>0.19"
  gem "json_pure", "~>1.8"
end

group :development do
  gem "gemspec_deps_gen", "~>1.1"
  gem "gemcutter", "~>0.7"
end

group :oracle do
  gem "ruby-oci8", "2.1.7"
end

group :test do
  gem "rspec"
  gem "mocha"
end
