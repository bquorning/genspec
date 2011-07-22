# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'genspec'
  s.version = "0.2.0"

  s.authors = ["Colin MacKenzie IV"]
  s.date = '2010-07-08'
  s.description = %q{Simple, expressive Rails 3 generator testing for RSpec. For the Rails 2.3 version, use genspec 0.1.x.}
  s.email = 'sinisterchipmunk@gmail.com'
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = `git ls-files`.split(/\n/)
  s.homepage = %q{http://www.thoughtsincomputation.com}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Simple, expressive Rails 3 generator testing for RSpec. For the Rails 2.3 version, use genspec 0.1.x.}
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'thor', '~> 0.14.6'
  s.add_dependency 'rspec', "~> 2.6.0"
  s.add_dependency 'sc-core-ext', "~> 1.2.1"
  s.add_dependency 'i18n', '~> 0.5.0'
end
