module Fett
  class GitHubStatusMessageComposer
    def self.compose(status)
      if status == "success"
        "I love this code. I love it more than sharks love blood"
      elsif status == "failure"
        "My great concern is not whether you have failed, but whether you are content with your failure"
      else
        "Don’t count every hour in the day, make every hour in the day count"
      end
    end
  end
end
