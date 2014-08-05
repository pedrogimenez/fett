module Fett
  class Repository
    attr_reader :last_pusher, :last_message, :last_commit_url, :last_branch
    attr_writer :last_pusher, :last_message, :last_commit_url, :last_branch

    def initialize(org, repository)
      @org = org
      @repository = repository
    end

    def jenkins_name
      "#{@org}.#{@repository}"
    end

    def fullname
      "#{@org}/#{@repository}"
    end

    def ==(another_repository)
      fullname == another_repository.fullname
    end
  end
end
