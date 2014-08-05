require "fett/github_status_message_composer"

describe Fett::GitHubStatusMessageComposer do
  it "composes a messages based on the given status" do
    expect(Fett::GitHubStatusMessageComposer.compose("success")).
      to eq("I love this code. I love it more than sharks love blood")
    expect(Fett::GitHubStatusMessageComposer.compose("failure")).
      to eq("My great concern is not whether you have failed, but whether you are content with your failure")
    expect(Fett::GitHubStatusMessageComposer.compose("pending")).
      to eq("Don’t count every hour in the day, make every hour in the day count")
  end
end
