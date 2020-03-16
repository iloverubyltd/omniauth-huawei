# frozen_string_literal: true

require_relative 'lib/omniauth/huawei/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-huawei'
  spec.version       = Omniauth::Huawei::VERSION
  spec.authors       = ['Alex Coles']
  spec.email         = ['alex@alexbcoles.com']

  spec.summary       = 'OmniAuth strategies for Huawei Mobile Services.'
  spec.description   = 'OmniAuth strategies for Huawei Mobile Services.'
  spec.homepage      = 'http://github.com/iloverubyltd/omnitauth-huawei'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'http://github.com/iloverubyltd/omnitauth-huawei.git'
  spec.metadata['changelog_uri'] = 'http://github.com/iloverubyltd/omnitauth-huawei/CHANGELOD.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) {
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'jwt', '~> 2'
  spec.add_dependency 'omniauth', '~> 1'
  spec.add_dependency 'omniauth-oauth2', '~> 1'

  spec.add_development_dependency 'addressable', '~> 2.7'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
end
