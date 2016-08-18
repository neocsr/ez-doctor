class BetterDoctor
  class Error < StandardError
  end

  CONFIG = Rails.configuration.better_doctor
  include HTTParty
  headers 'Accept' => 'application/json'

  base_uri "#{CONFIG['host']}:#{CONFIG['port']}/#{CONFIG['api_version']}"
  open_timeout CONFIG['open_timeout']
  read_timeout CONFIG['read_timeout']

  def self.search(name)
    resp = get("/doctors", {query: {name: name, user_key: CONFIG['user_key']}})
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
