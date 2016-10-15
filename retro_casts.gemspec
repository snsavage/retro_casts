# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'retro_casts/version'

Gem::Specification.new do |spec|
  spec.name          = "retro_casts"
  spec.version       = RetroCasts::VERSION
  spec.authors       = ["Scott Savage"]
  spec.email         = ["snsavage@gmail.com"]

  spec.summary       = %q{RetroCasts proivdes RailsCasts.com metadata in a command-line interface.}
  spec.description   = %q{RetroCasts provides a command-line interface for access to metdata from RailsCasts.com.  Features include episode lists, episode details, and search.}
  spec.homepage      = "https://github.com/snsavage/retro_casts"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.1"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "dotenv"

  spec.add_runtime_dependency "nokogiri", "~> 1.6"
end
