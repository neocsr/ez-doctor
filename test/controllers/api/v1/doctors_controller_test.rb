require 'test_helper'

class Api::V1::DoctorsControllerTest < ActionController::TestCase

  test "get search" do
    BetterDoctor.expects(:search)
      .with("John Doe")
    get :search, {name: "John Doe"}

    assert_response :success
  end

  test "get search with error" do
    BetterDoctor.expects(:search)
      .raises(BetterDoctor::Error)
    get :search, {name: "John Doe"}

    assert_response :bad_gateway
    assert_equal("{\"message\":\"Backend error\"}", @response.body)
  end

end
