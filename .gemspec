require 'English'
Gem::Specification.new do |gem|
  gem.name          = 'tftp container test suite'
  gem.homepage      = 'https://github.com/ISEexchange/tftp'
  gem.description   = %q('Test harness for this repo')
  gem.summary       = %q('Test harness for this repo')
  gem.license       = 'GPLv3'
  gem.files         = `git ls-files`.split($RS)
  gem.executables   = gem.files.grep(/^bin\//).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(/^(test|spec|features)\//)
  gem.authors       = `git log --format='%aN' | sort -u`.split($RS)
  gem.email         = `git log --format='%aE' | sort -u`.split($RS)
  gem.require_paths = ['lib']
  # Leave at zero
  gem.version       = '0.0.0'

  gem.add_development_dependency 'docker-api'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'rspec-core'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-expectations'
  gem.add_development_dependency 'rspec-mocks'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'friction'
  gem.add_development_dependency 'net-tftp'
end
