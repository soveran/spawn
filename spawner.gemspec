Gem::Specification.new do |s|
  s.name = "spawner"
  s.version = "0.0.1"
  s.date = "2008-08-24"
  s.summary = "Simple fixtures replacement for ActiveRecord"
  s.email = "michel@soveran.com"
  s.homepage = "http://github.com/soveran/spawner"
  s.description = "Generates Random data for test, demo, etc."
  s.has_rdoc = true
  s.authors = ["Michel Martens"]
  s.files = [
    "README.rdoc",
    "MIT-LICENSE",
    "spawner.gemspec",
    "lib/spawner.rb",
    "init.rb",
    "extras/samples.rake"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.extra_rdoc_files = ['README.rdoc']
  s.add_dependency("activerecord", ["> 0.0.0"])
end
