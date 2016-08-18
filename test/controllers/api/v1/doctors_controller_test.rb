require 'test_helper'

class Api::V1::DoctorsControllerTest < ActionController::TestCase

  test "get search" do
    stub_request(:get, "http://localhost:4000/2016-03-01/doctors?name=&user_key=demo")
      .with(:headers => {'Accept'=>'application/json'})
      .to_return(body: '{"name": "John"}')

    get :search

    assert_response :success
    assert_equal("{\"name\": \"John\"}", @response.body)
  end
end
