Gem::Specification.new do |spec|
  spec.name                   = "fett"
  spec.version                = "1.0.0"
  spec.date                   = "2014-08-05"
  spec.summary                = "Fett brings all the information about your builds right to your chat room"
  spec.description            = "Fett brings all the information about your builds right to your chat room"
  spec.authors                = ["Pedro Gimenez"]
  spec.email                  = ["me@pedro.bz"]
  spec.files                  = Dir["lib/**/*.rb"] + Dir["spec/**/*.rb"] + Dir["templates/*.xml.erb"]
  spec.homepage               = "https://github.com/pedrogimenez/fett"
  spec.extra_rdoc_files       = ["README.md"]
  spec.required_ruby_version  = ">= 2.1.0"
  spec.license                = "MIT"

  spec.add_runtime_dependency "redis"
  spec.add_runtime_dependency "sinatra"
  spec.add_runtime_dependency "sinatra-contrib"
  spec.add_runtime_dependency "nestful"
  spec.add_runtime_dependency "octokit"
  spec.add_runtime_dependency "jenkins_api_client"
  spec.add_runtime_dependency "tilt", "~> 1.4.1"

  spec.add_development_dependency "rspec",       "~> 3.0"
  spec.add_development_dependency "rspec-mocks", "~> 3.0.2"
end
