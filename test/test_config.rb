PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path('../../config/boot', __FILE__)
require 'crack'       
require 'crack/xml' 

ENV['PORT'] ||= '3000'

class MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Jupdateserver.tap { |app|  }
  end
end