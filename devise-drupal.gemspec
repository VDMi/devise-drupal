# -*- encoding: utf-8 -*-
require File.expand_path('../lib/devise/encryptable/encryptors/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Jeroen Bobbeldijk']
  gem.email         = 'jeroen@vdmi.nl'
  gem.description   = 'Drupal Hash implementation for Devise Encryptable'
  gem.summary       = 'Drupal Hash implementation for Devise Encryptable'
  gem.homepage      = 'http://github.com/jerbob92/drupal'
  gem.license       = 'Apache 2.0'

  gem.files         = Dir['Changelog.md', 'LICENSE', 'README.md', 'lib/**/*']
  gem.test_files    = Dir['test/**/*.rb']
  gem.name          = 'devise-drupal'
  gem.require_paths = ['lib']
  gem.version       = Devise::Encryptable::Encryptors::DrupalHash::VERSION

  gem.add_dependency 'devise-encryptable', '>= 0.1.2'
end

