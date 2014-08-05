ENV["FETT_GITHUB_LOGIN"]    = "pedrogimenez"
ENV["FETT_GITHUB_PASSWORD"] = "pedrogimenez"
ENV["FETT_URL"]             = "https://fett.pedrogimenez.com"

require "fett/github"

module Fett
  class GitHubStatusMessageComposer; end
end

module Octokit
  class Client; end
end

describe Fett::GitHub do
  it "creates a new hook in GitHub" do
    repository = double(:repository, fullname: "pedrogimenez/fett")
    client = double(:client)

    expect(Octokit::Client).to receive(:new).and_return(client)
    expect(client).to receive(:create_hook).with("pedrogimenez/fett", "web", *params)

    Fett::GitHub.new_hook(repository)
  end

  it "sets the last build status" do
    repository = double(:repository, fullname: "pedrogimenez/fett")
    client = double(:client)

    expect(Fett::GitHubStatusMessageComposer).to receive(:compose).with("success").and_return("yay!")
    expect(Octokit::Client).to receive(:new).and_return(client)
    expect(client).to receive(:create_status)
      .with("pedrogimenez/fett", "7240a7b561e56702889565e46d6ba93784fe23c5", "success", { description: "yay!" })

    Fett::GitHub.new_build_status(repository, "7240a7b561e56702889565e46d6ba93784fe23c5", "success")
  end

  def params
    [{
      url: "https://fett.pedrogimenez.com/builds",
      content_type: "json"
    },
    {
      events: ["push"],
      active: true
    }]
  end
end
