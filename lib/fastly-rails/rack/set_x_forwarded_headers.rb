module FastlyRails
  module Rack
    # Set the X-Forwarded-Proto header to reflect
    # the browser/Fastly connection.
    #
    # Useful for apps hosted on Heroku, where the X-Forwarded
    # headers are set by the Heroku router to represent only the
    # direct connection from Fastly's proxy server to Heroku.
    #
    # Example usage:
    # ```
    # config.middleware.insert_after(Rack::MethodOverride, FastlyRails::Rack::SetXForwardedHeaders)
    # ```
    class SetXForwardedHeaders
      def initialize(app)
        @app = app
      end

      def call(env)
        if is_behind_fastly?(env)
          if is_ssl?(env)
            env["HTTPS"] = "on"
            env["HTTP_X_FORWARDED_PROTO"] = "https"
          else
            env["HTTP_X_FORWARDED_PROTO"] = "http"
          end
          # Disambiguate
          env.delete("HTTP_X_FORWARDED_PORT")
          env.delete("HTTP_X_FORWARDED_SSL")
          env.delete("HTTP_X_FORWARDED_SCHEME")
        end
        @app.call(env)
      end

      def is_behind_fastly?(env)
        env["HTTP_FASTLY_CLIENT_IP"].present?
      end

      def is_ssl?(env)
        env["HTTP_FASTLY_SSL"].present?
      end
    end
  end
end
