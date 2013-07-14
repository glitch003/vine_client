Gem::Specification.new do |s|
  s.name        = 'vine_client'
  s.version     = '0.0.1'
  s.date        = '2013-07-14'
  s.summary     = "vine_client"
  s.description = "ruby wraper for vine.co api"
  s.author      = "Roman Lozhkin"
  s.email       = "obrigan228@gmail.com"
  s.files = `git ls-files`.split("\n")
  s.required_ruby_version = '>= 1.9.2'
  s.add_runtime_dependency 'faraday',                     '~> 0.8'
  s.add_runtime_dependency 'faraday_middleware',          '~> 0.8'
  s.require_paths = ['lib']
  s.homepage    = 'https://github.com/obrigan228/vine_client'
  s.licenses = ['MIT', 'GPL-2']
end