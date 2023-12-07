
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "omniauth/smarthr/version"

Gem::Specification.new do |spec|
  spec.name          = "omniauth-smarthr"
  spec.version       = OmniAuth::SmartHR::VERSION
  spec.licenses       = ["MIT"]
  spec.authors       = ["SmartHR, Inc."]
  spec.email         = ["oss@smarthr.co.jp"]

  spec.summary       = "SmartHR OAuth2 Strategy for OmniAuth"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/kufu/omniauth-smarthr"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'omniauth', ">= 2.1.1"
  spec.add_runtime_dependency 'omniauth-oauth2', ">= 1.8.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
