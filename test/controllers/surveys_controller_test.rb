require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  test "should get send" do
    get :send
    assert_response :success
  end

end
