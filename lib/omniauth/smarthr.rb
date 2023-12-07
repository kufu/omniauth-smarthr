require "omniauth/smarthr/version"
require "omniauth/strategies/smarthr"

OmniAuth.config.add_camelization("smarthr", "SmartHR")
OmniAuth.config.allowed_request_methods = %i(get post)
