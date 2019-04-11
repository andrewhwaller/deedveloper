
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "deedveloper/version"

Gem::Specification.new do |spec|
  spec.name          = "deedveloper"
  spec.version       = Deedveloper::VERSION
  spec.authors       = "Andrew Waller"
  spec.email         = "andrew@andrewhwaller.com"

  spec.summary       = "Deedveloper is an Indeed.com search engine in Ruby."
  spec.homepage      = "https://github.com/andrewhwaller/deedveloper"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/andrewhwaller/deedveloper"
    spec.metadata["changelog_uri"] = "https://github.com/andrewhwaller/deedveloper"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "nokogiri"
  spec.add_dependency "open_uri_redirections"
end
