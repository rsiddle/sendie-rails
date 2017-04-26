# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'sendie/version'

Gem::Specification.new do |s|
  s.name        = 'sendie-rails'
  s.version     = Sendie::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['']
  s.email       = ['']
  s.homepage    = ''
  s.license     = 'MIT'
  s.summary     = %q{}
  s.description = %q{}

  s.rubyforge_project = 'sendie-rails'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.0.0'
  s.add_dependency 'actionmailer', '>= 3.0.0'
  s.add_dependency 'activesupport', '>= 2.1.0'
end

