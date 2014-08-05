require "fett/build_status_notifier"

module Fett
  class Repositories; end
  class GitHub; end
  class Slack; end
end

describe Fett::BuildStatusNotifier do
  it "notifies GitHub and Slack about the last build status" do
    repository = double(:repository)
    expect(Fett::Repositories).to receive(:repository_of_fullname).and_return(repository)
    expect(Fett::GitHub).to receive(:new_build_status)
      .with(repository, "7240a7b561e56702889565e46d6ba93784fe23c5", "success")
    expect(Fett::Slack).to receive(:build_status_message)
      .with(repository, "success")

    Fett::BuildStatusNotifier.notify("pedrogimenez.fett", "7240a7b561e56702889565e46d6ba93784fe23c5", "success")
  end
end
