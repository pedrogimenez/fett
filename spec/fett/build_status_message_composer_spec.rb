require "fett/build_status_message_composer"

describe Fett::BuildStatusMessageComposer do
  let(:repository) do
    double(:repository,
      last_pusher: "pedrogimenez",
      last_message: "Testing fett.",
      last_commit_url: "https://github.com/pedrogimenez/fett/commit/7240a7b561e56702889565e46d6ba93784fe23c5",
      last_branch: "master",
      fullname: "pedrogimenez/fett")
  end

  it "composes a message when the status is `pending`" do
    message = Fett::BuildStatusMessageComposer.compose(repository, "pending")

    expect(message).to eq("Build of pedrogimenez/fett@<#{repository.last_commit_url}|master> by pedrogimenez.")
  end

  it "composes a message when the status is `success`" do
    message = Fett::BuildStatusMessageComposer.compose(repository, "success")

    expect(message).to eq("Build of pedrogimenez/fett@<#{repository.last_commit_url}|master> by pedrogimenez. Well done :sparkles:.")
  end

  it "composes a message when the status is `failure`" do
    message = Fett::BuildStatusMessageComposer.compose(repository, "failure")

    expect(message).to eq("Build of pedrogimenez/fett@<#{repository.last_commit_url}|master> by pedrogimenez.")
  end
end
