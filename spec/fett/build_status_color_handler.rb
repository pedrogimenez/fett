require "fett/build_status_color_handler"

describe Fett::BuildStatusColorHandler do
  it "returns a color based on the status" do
    expect(Fett::BuildStatusColorHandler.color("success")).to eq("#36a64f")
    expect(Fett::BuildStatusColorHandler.color("failure")).to eq("#36a64f")
    expect(Fett::BuildStatusColorHandler.color("pending")).to eq("#36a64f")
  end
end
