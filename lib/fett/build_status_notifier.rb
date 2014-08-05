module Fett
  class BuildStatusNotifier
    def self.notify(jenkins_name, commit_sha1, status)
      fullname = jenkins_name.sub(/\./, "/")
      repository = Repositories.repository_of_fullname(fullname)

      GitHub.new_build_status(repository, commit_sha1, status)
      Slack.build_status_message(repository, status)
    end
  end
end
