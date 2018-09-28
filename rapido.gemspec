# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rapido/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails-rapido'
  spec.version       = Rapido::VERSION
  spec.authors       = ['Jonathan Kirst']
  spec.email         = ['jskirst@gmail.com']
  spec.license       = 'MIT'

  spec.summary       = 'Rails API Dryer-o'
  spec.description   = 'Opinionated RESTfull API controller library.'
  spec.homepage      = 'https://github.com/jskirst/rapido'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '> 1.15'
  spec.add_development_dependency 'rake', '> 10.0'
end
