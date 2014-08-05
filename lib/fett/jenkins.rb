module Fett
  class Jenkins
    URL      = ENV.fetch("FETT_JENKINS_URL")
    USERNAME = ENV.fetch("FETT_JENKINS_USERNAME")
    PASSWORD = ENV.fetch("FETT_JENKINS_PASSWORD")

    def self.new_job(repository, template)
      client.job.create(repository.jenkins_name, template.content)
    end

    def self.new_build(repository, params)
      client.job.build(repository.jenkins_name, params)
    end

    private

    def self.client
      JenkinsApi::Client.new(server_url: URL, username: USERNAME, password: PASSWORD)
    end

    private_class_method :client
  end
end
