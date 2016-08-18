require 'test_helper'

class Api::V1::DoctorsControllerTest < ActionController::TestCase

  test "get search" do
    get :search

    assert_response :success
    assert_equal "{}", @response.body
  end
end
