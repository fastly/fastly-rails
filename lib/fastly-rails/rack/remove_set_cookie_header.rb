module FastlyRails
  module Rack
    class RemoveSetCookieHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)

        unless ENV["FASTLY_CACHE_DISABLED"].present?
          if headers["Surrogate-Control"] || headers["Surrogate-Key"]
            headers.delete("Set-Cookie")
          end
        end

        [status, headers, response]
      end
    end
  end
end
