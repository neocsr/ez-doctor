class BetterDoctor
  CONFIG = Rails.configuration.better_doctor
  include HTTParty

  base_uri "#{CONFIG['host']}:#{CONFIG['port']}"

  def self.search(name)
    resp = get("/search", {query: {name: name}})
    resp.body
  end

end
