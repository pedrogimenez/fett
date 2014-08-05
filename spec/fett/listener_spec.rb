require "fett/listener"

module Fett
  class RepositoryFactory; end
  class Jenkins; end
  class GitHub; end
  class Slack; end
  class Repositories; end
  class Template; end
end

describe Fett::Listener do
  it "listens new repositories" do
    repository = double(:repository)
    template = double(:template)
    expect(Fett::RepositoryFactory).to receive(:build).with("pedrogimenez/fett").and_return(repository)
    expect(Fett::Template).to receive(:new).and_return(template)
    expect(Fett::Jenkins).to receive(:new_job).with(repository, template)
    expect(Fett::GitHub).to receive(:new_hook).with(repository)
    expect(Fett::Slack).to receive(:listening_message).with(repository)
    expect(Fett::Repositories).to receive(:put).with(repository)

    Fett::Listener.listen("pedrogimenez/fett")
  end
end
