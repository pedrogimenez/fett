module Fett
  class GitHub
    LOGIN    = ENV.fetch("FETT_GITHUB_LOGIN")
    PASSWORD = ENV.fetch("FETT_GITHUB_PASSWORD")
    FETT_URL = ENV.fetch("FETT_URL")

    def self.new_hook(repository)
      client.create_hook(repository.fullname, "web", *params)
    end

    def self.new_build_status(repository, commit_sha1, status)
      message = GitHubStatusMessageComposer.compose(status)
      client.create_status(repository.fullname, commit_sha1, status, description: message)
    end

    private

    def self.client
      Octokit::Client.new(login: LOGIN, password: PASSWORD)
    end

    def self.params
      [{
        url: "#{FETT_URL}/builds",
        content_type: "json"
      },
      {
        events: ["push"],
        active: true
      }]
    end

    private_class_method :client, :params
  end
end
