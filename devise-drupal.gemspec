# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ['Jeroen Bobbeldijk']
  gem.email         = 'jeroen@vdmi.nl'
  gem.description   = 'Drupal Hash implementation for Devise Encryptable'
  gem.summary       = 'Drupal Hash implementation for Devise Encryptable'
  gem.homepage      = 'https://github.com/jerbob92/devise-drupal'
  gem.license       = 'Apache 2.0'

  gem.files         = Dir['Changelog.md', 'LICENSE', 'README.md', 'lib/**/*']
  gem.test_files    = Dir['test/**/*.rb']
  gem.name          = 'devise-drupal'
  gem.require_paths = ['lib']
  gem.version       = "0.0.3"

  gem.add_dependency 'devise-encryptable', '>= 0.1.2'
end

