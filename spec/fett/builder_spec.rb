require "fett/builder"

module Fett
  class Repositories; end
  class Jenkins; end
end

describe Fett::Builder do
  it "builds a commit and returns the result" do
    repository = double(:repository, :last_pusher= => nil, :last_message= => nil, :last_commit_url= => nil, :last_branch= => nil)

    expect(Fett::Repositories).to receive(:repository_of_fullname).with("pedrogimenez/fett").and_return(repository)
    expect(Fett::Jenkins).to receive(:new_build).with(repository, params)
    expect(Fett::Repositories).to receive(:put).with(repository)

    Fett::Builder.build("pedrogimenez/fett", "pedrogimenez", "Testing fett.",
      "https://github.com/pedrogimenez/fett/commit/7240a7b561e56702889565e46d6ba93784fe23c5", "refs/heads/master", params)
  end

  def params
    { GIT_SHA1: "7240a7b561e56702889565e46d6ba93784fe23c5", GIT_BRANCH: "master" }
  end
end
