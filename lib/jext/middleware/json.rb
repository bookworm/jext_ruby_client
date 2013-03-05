module Jext
  module Middleware
    class JSON < Faraday::Middleware
      ACCEPT    = 'Accept'.freeze
      MIME_TYPE = 'application/json'.freeze

      def call(env)
        env[:request_headers][ACCEPT] ||= MIME_TYPE
        @app.call env
      end
    end
  end
end
