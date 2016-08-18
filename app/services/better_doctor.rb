class BetterDoctor
  class Error < StandardError
  end

  CONFIG = Rails.configuration.better_doctor
  include HTTParty

  base_uri "#{CONFIG['host']}:#{CONFIG['port']}"
  open_timeout CONFIG['open_timeout']
  read_timeout CONFIG['read_timeout']

  def self.search(name)
    resp = get("/search", {query: {name: name}})
    resp.body
  rescue => e
    raise Error, "#{e.class}: #{e.message}"
  end

  def self.cached_search(name)
    Rails.cache.fetch(name, expires_in: 30.minutes) do
      search(name)
    end
  end
end
