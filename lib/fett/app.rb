require "json"
require "sinatra/base"
require "sinatra/json"
require "octokit"
require "jenkins_api_client"

module Fett
  class App < Sinatra::Base
    helpers Sinatra::JSON

    before do
      Fett::RedisConnection.initialize
    end

    get "/ping" do
      "PONG"
    end

    post "/repositories" do
      transaction success: 204 do
        Fett::Listener.listen(params[:repository])
        headers["location"] = "#{ENV.fetch("FETT_URL")}/builds"
      end
    end

    post "/builds" do
      transaction success: 204 do
        halt 400 if %w{ping pull_request}.include?(request.env["HTTP_X_GITHUB_EVENT"])

        response = JSON.parse(request.env["rack.input"].read, symbolize_names: true)

        Fett::Builder.build(
          response[:repository][:full_name],
          response[:pusher][:name],
          response[:head_commit][:message],
          response[:head_commit][:url],
          response[:ref],
          { GIT_SHA1: response[:head_commit][:id], GIT_BRANCH: response[:ref] }
        )
      end
    end

    post "/builds/status" do
      response = JSON.parse(request.env["rack.input"].read, symbolize_names: true)

      status = "pending"

      if response[:build][:status] == "SUCCESS"
        status = "success"
      elsif response[:build][:status] == "FAILURE"
        status = "failure"
      end

      return unless %w{STARTED FINISHED}.include?(response[:build][:phase])

      Fett::BuildStatusNotifier.notify(response[:name], response[:build][:parameters][:GIT_SHA1], status)
    end

    def transaction(options, &block)
      begin
        status options[:success]

        response = yield

        return if options[:success] == 204

        json response
      rescue RuntimeError => error
        status 400
        json error: error.message
      end
    end
  end
end
