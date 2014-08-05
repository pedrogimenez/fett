require "fett/repository"
require "fett/repository_factory"
require "fett/repositories"
require "fett/redis_connection"

describe Fett::Repositories do
  before do
    Fett::RedisConnection.initialize
    Fett::RedisConnection.client.flushdb
  end

  it "persists a repository" do
    client = double(:client)
    repository = Fett::RepositoryFactory.build("pedrogimenez/fett")

    expect(Fett::RedisConnection).to receive(:client).and_return(client)
    expect(client).to receive(:set)

    Fett::Repositories.put(repository)
  end

  it "updates a repository" do
    new_repository = Fett::RepositoryFactory.build("pedrogimenez/fett")
    Fett::Repositories.put(new_repository)

    new_repository.last_pusher = "pedrogimenez"
    Fett::Repositories.put(new_repository)

    repository = Fett::Repositories.repository_of_fullname("pedrogimenez/fett")
    expect(repository.last_pusher).to eq("pedrogimenez")
  end

  it "returns a repository of fullname" do
    repository = Fett::RepositoryFactory.build("pedrogimenez/fett")
    Fett::Repositories.put(repository)

    expect(Fett::Repositories.repository_of_fullname("pedrogimenez/fett")).to eq(repository)
  end
end
