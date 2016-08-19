require 'test_helper'

class Api::V1::DoctorsControllerTest < ActionController::TestCase

  test "get search" do
    BetterDoctor.expects(:search)
      .with("John Doe")
    get :search, {name: "John Doe"}

    assert_response :success
  end

end
