# Error class modeled after error class in octokit https://github.com/pengwynn/octokit/blob/master/lib/octokit/error.rb
module Jext
  class Error < StandardError
    def initialize(response=nil)
      @response = response
      super(build_error_message)
    end

    def response_body
      @response_body ||=
        if (body = @response[:body]) && !body.empty?
          if body.is_a?(String)
            MultiJson.load(body, :symbolize_keys => true)
          else
            body
          end
        else
          nil
        end
    end

    private

    def build_error_message
      return nil  if @response.nil?

      message = if response_body
        ": #{response_body[:error] || response_body[:message] || ''}"
      else
        ''
      end
      errors = unless message.empty?
        response_body[:errors] ?  ": #{response_body[:errors].map{|e|e[:message]}.join(', ')}" : ''
      end
      "#{@response[:method].to_s.upcase} #{@response[:url].to_s}: #{@response[:status]}#{message}#{errors}"
    end
  end

  # 400 HTTP status code
  class BadRequest < Error; end

  # 401 HTTP status code
  class Unauthorized < Error; end

  # 403 HTTP status code
  class Forbidden < Error; end

  # 404 HTTP status code
  class NotFound < Error; end

  # 406 HTTP status code
  class NotAcceptable < Error; end

  # 422 HTTP status code
  class UnprocessableEntity < Error; end

  # 500 HTTP status code
  class InternalServerError < Error; end

  # 501 HTTP status code
  class NotImplemented < Error; end

  # 502 HTTP status code
  class BadGateway < Error; end

  # 503 HTTP status code
  class ServiceUnavailable < Error; end
end
