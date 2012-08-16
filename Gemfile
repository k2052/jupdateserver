source :rubygems

# Server requirements
gem 'thin' # or mongrel

# Project requirements
gem 'rake'

# Component requirements
gem 'crack'
gem 'builder'
gem 'tzinfo'
gem 'mongo_mapper'
gem 'mongomapper_ext',    :git     => "git://github.com/bookworm/mongomapper_ext.git" 
gem 'bson_ext',           :require => "mongo"
gem 'padrino-responders', :git     => 'git://github.com/bookworm/padrino-responders.git'

# Test requirements
group :test do
  gem 'mini_shoulda',        :require => 'mini_shoulda'
  gem 'minitest', "~>2.6.0", :require => "minitest/autorun"
  gem 'rack-test',           :require => "rack/test"
  gem 'ffaker',              :require => 'ffaker'
  gem 'webmock'
end

# Padrino Stable Gem
gem 'padrino', '0.10.7'