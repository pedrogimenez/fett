require "json"
require "nestful"

module Fett
  class Slack
    SLACK_URL = ENV.fetch("FETT_SLACK_URL")

    def self.listening_message(repository)
      send_listening_message("kk, I'm listening to https://github.com/#{repository.fullname}")
    end

    def self.build_status_message(repository, status)
      send_build_status_message(BuildStatusMessageComposer.compose(repository, status), status)
    end

    private

    def self.send_listening_message(message)
      send_message(text: message)
    end

    def self.send_build_status_message(message, status)
      color = BuildStatusColorHandler.color(status)

      attachment = {
        color: color,
        fields: [ value: message, short: true ]
      }

      send_message(attachments: [attachment])
    end

    def self.send_message(params)
      params.merge!(username: "Fett", icon_url: "http://imagizer.imageshack.us/v2/150x100q90/538/K7OlPJ.png")
      Nestful.post(SLACK_URL, payload: JSON.dump(params))
    end

    private_class_method :send_listening_message, :send_build_status_message, :send_message
  end
end
