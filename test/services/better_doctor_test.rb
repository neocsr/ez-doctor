require 'test_helper'

class BetterDoctorTest < ActiveSupport::TestCase
  test "search by name" do
    stub_request_with_name
    resp = BetterDoctor.search("John Doe")

    assert_requested(:get, "#{expected_base_url}?name=John%20Doe&user_key=demo",
      times: 1)
    assert_equal("{\"name\": \"John\"}", resp)
  end

  test "multiple cached searches by name make only one request" do
    stub_request_with_name
    BetterDoctor.cached_search("John Doe")
    BetterDoctor.cached_search("John Doe")
    resp = BetterDoctor.cached_search("John Doe")

    assert_requested(:get, "#{expected_base_url}?name=John%20Doe&user_key=demo",
      times: 1)
    assert_equal("{\"name\": \"John\"}", resp)
  end

  test "re-raise exceptions as BetterDoctor errors" do
    stub_request(:get, expected_base_url)
      .with(query: {"name" => "John Doe", "user_key" => "demo"})
      .to_raise(Errno::ECONNREFUSED)

    assert_raises(BetterDoctor::Error) do
      BetterDoctor.search("John Doe")
    end
  end

  def stub_request_with_name
    stub_request(:get, expected_base_url)
      .with(query: {"name" => "John Doe", "user_key" => "demo"})
      .to_return(body: '{"name": "John"}')
  end

  def expected_base_url
    "http://localhost:4000/2016-03-01/doctors"
  end

end
