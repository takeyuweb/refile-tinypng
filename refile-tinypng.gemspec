# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'refile/tinypng/version'

Gem::Specification.new do |spec|
  spec.name          = "refile-tinypng"
  spec.version       = Refile::Tinypng::VERSION
  spec.authors       = ["Yuichi Takeuchi"]
  spec.email         = ["uzuki05@takeyu-web.com"]

  spec.summary       = %q{Image processing via TinyPNG for Refile}
  spec.homepage      = "https://github.com/takeyuweb/refile-tinypng"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "refile", "~> 0.5"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
