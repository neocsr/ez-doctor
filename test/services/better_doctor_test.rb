require 'test_helper'

class BetterDoctorTest < ActiveSupport::TestCase
  test "search by name" do
    stub_request(:get, "http://localhost:4000/search")
      .with(query: {"name" => "John Doe"})
      .to_return(body: '{"name": "John"}')

    resp = BetterDoctor.search("John Doe")

    assert_requested(:get, "http://localhost:4000/search?name=John%20Doe",
      times: 1)
    assert_equal("{\"name\": \"John\"}", resp)
  end

  test "multiple cached searches by name make only one request" do
    stub_request(:get, "http://localhost:4000/search")
      .with(query: {"name" => "John Doe"})
      .to_return(body: '{"name": "John"}')

    BetterDoctor.cached_search("John Doe")
    BetterDoctor.cached_search("John Doe")
    resp = BetterDoctor.cached_search("John Doe")

    assert_requested(:get, "http://localhost:4000/search?name=John%20Doe",
      times: 1)
    assert_equal("{\"name\": \"John\"}", resp)
  end

end
