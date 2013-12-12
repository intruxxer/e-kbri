# -*- encoding: utf-8 -*-
# stub: guard-rspec 4.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "guard-rspec"
  s.version = "4.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thibaud Guillaume-Gentil"]
  s.date = "2013-12-04"
  s.description = "Guard::RSpec automatically run your specs (much like autotest)."
  s.email = "thibaud@thibaud.me"
  s.homepage = "https://rubygems.org/gems/guard-rspec"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "Guard gem for RSpec"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard>, [">= 2.1.1"])
      s.add_runtime_dependency(%q<rspec>, ["< 4.0", ">= 2.14"])
      s.add_development_dependency(%q<bundler>, [">= 1.3.5"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<launchy>, [">= 0"])
    else
      s.add_dependency(%q<guard>, [">= 2.1.1"])
      s.add_dependency(%q<rspec>, ["< 4.0", ">= 2.14"])
      s.add_dependency(%q<bundler>, [">= 1.3.5"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<launchy>, [">= 0"])
    end
  else
    s.add_dependency(%q<guard>, [">= 2.1.1"])
    s.add_dependency(%q<rspec>, ["< 4.0", ">= 2.14"])
    s.add_dependency(%q<bundler>, [">= 1.3.5"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<launchy>, [">= 0"])
  end
end
