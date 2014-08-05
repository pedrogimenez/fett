require "redis"

module Fett
  class RedisConnection
    HOST     = ENV.fetch("FETT_REDIS_HOST")
    PORT     = ENV.fetch("FETT_REDIS_PORT")
    PASSWORD = ENV.fetch("FETT_REDIS_PASSWORD")
    DATABASE = ENV.fetch("FETT_REDIS_DATABASE")

    def self.initialize
      params = { host: HOST, port: PORT, db: DATABASE }
      params.merge!(password: PASSWORD) unless PASSWORD.empty?
      @@client ||= ::Redis.new(params)
    end

    def self.client
      @@client
    end
  end
end
