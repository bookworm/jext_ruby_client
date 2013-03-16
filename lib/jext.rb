require 'her'
require 'jext/version'
require 'jext/error'
require 'faraday_middleware'
require 'jext/middleware/raise_error'
require 'jext/middleware/parse'
require 'jext/middleware/json'

module Jext
  def self.api
    @api
  end

  def self.configure(&blk)
    options = OpenStruct.new
    yield(options)

    options.url ||= 'http://jext.herokuapp.com'

    @api = Her::API.new
    @api.setup :url => options.url do |connection|
      # Request Middleware
      connection.use Faraday::Request::UrlEncoded
      connection.use Jext::Middleware::JSON

      # Response Middleware
      connection.use Jext::Middleware::Parse
      connection.use Jext::Middleware::RaiseError
      connection.use Faraday::Adapter::NetHttp
    end
  end
  
  # AutoLoad Resource Classes
  autoload :Extension, 'jext/resources/Extension'
end
