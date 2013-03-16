module Jext
  module Middleware
    class RaiseError < Faraday::Response::Middleware
      ERROR_MAP = {
        400 => Jext::BadRequest,
        401 => Jext::Unauthorized,
        403 => Jext::Forbidden,
        404 => Jext::NotFound,
        406 => Jext::NotAcceptable,
        422 => Jext::UnprocessableEntity,
        500 => Jext::InternalServerError,
        501 => Jext::NotImplemented,
        502 => Jext::BadGateway,
        503 => Jext::ServiceUnavailable
      }

      def on_complete(response)
        puts response.inspect
        key = response[:status].to_i
        raise ERROR_MAP[key].new(response) if ERROR_MAP.has_key? key
      end
    end
  end
end
