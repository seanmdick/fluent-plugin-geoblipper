# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.name        = "fluent-plugin-geoblipper"
  gem.version     = "0.0.4.5"
  gem.authors     = ["Sean Dick", "Change.org"]
  gem.email       = ["sean@change.org"]
  gem.homepage    = "https://github.com/seanmdick/fluent-plugin-geoblipper"
  gem.summary     = %q{Fluentd plugin to send a buffered list of lat/long pairs to pubnub}
  gem.description = %q{Fluentd plugin to convert ips to latitude/longitude pairs for publication on a specified pubnub channel}
  gem.license     = "MIT"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "fluentd"
  gem.add_runtime_dependency "pubnub"
  gem.add_runtime_dependency "geoip"

  gem.add_development_dependency "bundler"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
