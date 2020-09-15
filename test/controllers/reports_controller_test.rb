require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reports_index_url
    assert_response :success
  end

  test "should get show_calendar" do
    get reports_show_calendar_url
    assert_response :success
  end

  test "should get show_report_form" do
    get reports_show_report_form_url
    assert_response :success
  end

  test "should get save_report" do
    get reports_save_report_url
    assert_response :success
  end

end
