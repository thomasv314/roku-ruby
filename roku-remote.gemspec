# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'roku-ruby'
  spec.version       = '0.1.0'
  spec.authors       = ['Thomas Vendetta']
  spec.email         = ['thomas@vendetta.io']

  spec.summary       = 'Ruby Roku Remote'
  spec.description   = 'Ruby Roku Remote'
  spec.homepage      = 'https://github.com/thomasv314'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ssdp', '1.1.5'
  spec.add_dependency 'httparty'
  spec.add_dependency 'curses'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
