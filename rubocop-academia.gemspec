Gem::Specification.new do |s|
  s.name        = 'rubocop-academia'
  s.version     = '0.1.0'
  s.date        = '2019-11-21'
  s.summary     = "Academia-specific rubocop cops"
  s.description = "Rubocop cops that provide linting for Academia.edu's codebase"
  s.authors     = ["Nick White"]
  s.email       = 'nickwhite@academia.edu'
  s.files       = ["lib/rubocop-academia.rb", "lib/rubocop/cop/academia/on_replica.rb"]
  s.homepage    = 'https://rubygems.org/gems/rubocop-academia'
  s.license     = 'MIT'
end
