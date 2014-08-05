module Fett
  class BuildStatusColorHandler
    def self.color(status)
      if status == "success"
        color = "#36a64f"
      elsif status == "failure"
        color = "#d00000"
      elsif status == "pending"
        color = "#ffcc66"
      end
    end
  end
end
