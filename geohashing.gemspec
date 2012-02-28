$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'geohashing/version'

Gem::Specification.new do |s|
  s.name = "geohashing"
  s.version = Geohashing::VERSION
  s.authors = ["Harry Schwartz"]
  s.email = ["hrs@cs.wm.edu"]

  s.summary = "XKCD geohashing algorithm"
  s.description = "Given your coordinates, yields today's geohashing meetup location"
  s.homepage = "http://github.com/hrs/geohashing"

  s.files = Dir.glob("lib/**/*.rb")
  s.test_files = Dir.glob("spec/**/*.rb")

  s.add_development_dependency 'rspec', '~> 2.5'
end

