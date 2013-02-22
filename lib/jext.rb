require 'her'
require 'jext/version'
require 'jext/middleware/parse'

module Jext
  def self.api
    @api
  end

  def self.configure(&blk)
    options = OpenStruct.new
    yield(options)

    @api = Her::API.new
    @api.setup :url => options[:url] do |connection|
      # Request Middleware
      connection.use Faraday::Request::UrlEncoded

      # Response Middleware
      connection.use Jext::Middleware::Parse
      connection.use Faraday::Adapter::NetHttp
    end
  end
  
  # AutoLoad Resource Classes
  autoload :Extension, 'jext/resources/Extension'
end
