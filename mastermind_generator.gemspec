# frozen_string_literal: true

require "./lib/mastermind_generator/version"

Gem::Specification.new do |spec|
  spec.name          = "mastermind_generator"
  spec.version       = MastermindGenerator::VERSION
  spec.authors       = ["Sıtkı Bağdat"]
  spec.email         = ["sbagdat@gmail.com"]

  spec.summary       = "Fully customizable mastermind game generator."
  spec.description   = "Mastermind* Generator is a fully customizable mastermind (or master mind) game generator. "\
     "It supports using custom items other than classic color variations. It can also generate multi-player games."
  spec.homepage      = "https://github.com/sbagdat/mastermind_generator"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/sbagdat/mastermind_generator/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
