module Fett
  class BuildStatusMessageComposer
    def self.compose(repository, status)
      message = "Build of #{repository.fullname}@<#{repository.last_commit_url}|#{repository.last_branch}> by #{repository.last_pusher}."
      message += " Well done :sparkles:." if status == "success"
      message
    end
  end
end
