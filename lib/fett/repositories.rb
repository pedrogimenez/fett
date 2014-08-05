module Fett
  class Repositories
    def self.put(repository)
      RedisConnection.client.set("repositories:#{repository.fullname}", Marshal.dump(repository))
    end

    def self.repository_of_fullname(fullname)
      Marshal.load(RedisConnection.client.get("repositories:#{fullname}"))
    end
  end
end
