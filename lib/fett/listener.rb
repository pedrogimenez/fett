module Fett
  class Listener
    FETT_URL = ENV.fetch("FETT_URL")

    def self.listen(fullname)
      repository = RepositoryFactory.build(fullname)

      template = Template.new("default", {
        :name         => "default",
        :repo         => "git@github.com:#{fullname}.git",
        :callback_url => "#{FETT_URL}/builds/status"
      })

      Jenkins.new_job(repository, template)
      GitHub.new_hook(repository)
      Slack.listening_message(repository)
      Repositories.put(repository)
    end
  end
end
