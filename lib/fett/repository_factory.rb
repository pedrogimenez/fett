module Fett
  class RepositoryFactory
    def self.build(fullname)
      org, repository = fullname.split("/")
      Fett::Repository.new(org, repository)
    end
  end
end
