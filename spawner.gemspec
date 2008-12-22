Gem::Specification.new do |s|
  s.name = "spawner"
  s.version = "0.0.5"
  s.date = "2008-12-18"
  s.summary = "Simple fixtures replacement for Sequel, ActiveRecord and probably many other ORMs"
  s.email = "michel@soveran.com"
  s.homepage = "http://github.com/soveran/spawner"
  s.description = "Simple fixtures replacement that allows to populate the database with custom data."
  s.has_rdoc = true
  s.authors = ["Michel Martens"]
  s.files = [
    "README.rdoc",
    "MIT-LICENSE",
    "spawner.gemspec",
    "lib/spawner.rb",
    "rails/init.rb",
    "extras/samples.rake"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.extra_rdoc_files = ['README.rdoc']
end
