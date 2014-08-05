ENV["FETT_SLACK_URL"] = "https://slack.com"

require "json"
require "fett/slack"

module Nestful
  class Request; end
end

module Fett
  class BuildStatusMessageComposer; end
  class BuildStatusColorHandler; end
end

describe Fett::Slack do
  it "sends a message to Slack when a repository is added to the system" do
    repository = double(:repository, fullname: "pedrogimenez/fett")
    expect(Nestful).to receive(:post).with("https://slack.com", listening_message_params)

    Fett::Slack.listening_message(repository)
  end

  it "sends a message to Slack about the last build status" do
    repository = double(:repository)

    expect(Fett::BuildStatusMessageComposer).to receive(:compose).with(repository, "success").and_return("yay!")
    expect(Fett::BuildStatusColorHandler).to receive(:color).with("success").and_return("#fff000")
    expect(Nestful).to receive(:post).with("https://slack.com", build_message_params)

    Fett::Slack.build_status_message(repository, "success")
  end

  def listening_message_params
    {
      payload: JSON.dump(
        text: "kk, I'm listening to https://github.com/pedrogimenez/fett",
        username: "Fett",
        icon_url: "http://imagizer.imageshack.us/v2/150x100q90/538/K7OlPJ.png")
    }
  end

  def build_message_params
    {
      payload: JSON.dump(
        attachments: [
          color: "#fff000",
          fields: [ value: "yay!", short: true ]
        ],
        username: "Fett",
        icon_url: "http://imagizer.imageshack.us/v2/150x100q90/538/K7OlPJ.png")
    }
  end
end
