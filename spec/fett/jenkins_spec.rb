ENV["FETT_JENKINS_URL"]      = "https://jenkins.pedrogimenez.com"
ENV["FETT_JENKINS_USERNAME"] = "pedrogimenez"
ENV["FETT_JENKINS_PASSWORD"] = "pedrogimenez"

require "fett/jenkins"

module JenkinsApi
  class Client; end
end

describe Fett::Jenkins do
  it "creates a new job in Jenkins" do
    client = double(:client)
    repository = double(:repository, jenkins_name: "pedrogimenez.fett")
    template = double(:template, content: "template")

    expect(JenkinsApi::Client).to receive(:new).and_return(client)
    expect(client).to receive(:job).and_return(client)
    expect(client).to receive(:create).with("pedrogimenez.fett", "template")

    Fett::Jenkins.new_job(repository, template)
  end

  it "runs a new build in Jenkins" do
    client = double(:client)
    repository = double(:repository, jenkins_name: "pedrogimenez.fett")

    expect(JenkinsApi::Client).to receive(:new).and_return(client)
    expect(client).to receive(:job).and_return(client)
    expect(client).to receive(:build).with("pedrogimenez.fett", params)

    Fett::Jenkins.new_build(repository, params)
  end

  def params
    { GIT_SHA1: "7240a7b561e56702889565e46d6ba93784fe23c5", GIT_BRANCH: "master" }
  end
end
