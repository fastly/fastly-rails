module FastlyRails
  module Rack
    class RemoveSetCookieHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)

        if headers["Surrogate-Control"] || headers["Surrogate-Key"]
          headers.delete("Set-Cookie")
        end

        [status, headers, response]
      end
    end
  end
end
