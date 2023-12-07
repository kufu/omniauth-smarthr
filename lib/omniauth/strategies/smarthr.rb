require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class SmartHR < OmniAuth::Strategies::OAuth2

      SMARTHR_AUTH_ENDPOINT = ENV.fetch("SMARTHR_AUTH_ENDPOINT", "https://app.smarthr.jp")
      private_constant :SMARTHR_AUTH_ENDPOINT

      option :name, "smarthr"
      option :client_options, {
        site: SMARTHR_AUTH_ENDPOINT,
        authorize_url: "/oauth/authorization",
        token_url: "/oauth/token",
        auth_scheme: :request_body,
      }
      option :redirect_uri, nil
      option :authorize_options, %i(scope state)

      uid { raw_info["id"] }

      info do
        {
          email: raw_info["email"],
        }
      end

      extra do
        skip_info? ? {} : {raw_info: raw_info}
      end

      def raw_info
        @raw_info ||= access_token.get("/api/v1/users/me", headers: {}, parse: :json).parsed
      end

      def callback_url
        options.redirect_uri || full_host + script_name + callback_path
      end

      def authorize_params
        super.tap do |params|
          options[:authorize_options].each do |k|
            value = request.params[k.to_s]

            next if [nil, ""].include?(value)

            params[k] = value
          end

          session["omniauth.state"] = params[:state] if params[:state]
        end
      end
    end
  end
end
