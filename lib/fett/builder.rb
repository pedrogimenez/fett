module Fett
  class Builder
    def self.build(fullname, last_pusher, last_message, last_commit_url, last_branch, params)
      repository = Repositories.repository_of_fullname(fullname)

      repository.last_pusher = last_pusher
      repository.last_message = last_message
      repository.last_commit_url =  last_commit_url
      repository.last_branch = last_branch.split("/").last

      Jenkins.new_build(repository, params)

      Repositories.put(repository)
    end
  end
end
