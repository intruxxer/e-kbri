# -*- encoding: utf-8 -*-
# stub: ffaker 1.22.1 ruby lib

Gem::Specification.new do |s|
  s.name = "ffaker"
  s.version = "1.22.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Emmanuel Oga"]
  s.date = "2013-11-24"
  s.description = "Faster Faker, generates dummy data."
  s.email = "EmmanuelOga@gmail.com"
  s.extra_rdoc_files = ["README.md", "LICENSE", "Changelog.md"]
  s.files = ["README.md", "LICENSE", "Changelog.md"]
  s.homepage = "http://github.com/emmanueloga/ffaker"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "ffaker"
  s.rubygems_version = "2.1.11"
  s.summary = "Faster Faker, generates dummy data."

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
  end
end
