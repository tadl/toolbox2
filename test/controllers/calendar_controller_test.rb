require 'test_helper'

class CalendarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calendar_index_url
    assert_response :success
  end

  test "should get workorders" do
    get calendar_workorders_url
    assert_response :success
  end

  test "should get sign" do
    get calendar_sign_url
    assert_response :success
  end

end
