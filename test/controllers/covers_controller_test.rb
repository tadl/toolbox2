require 'test_helper'

class CoversControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get covers_home_url
    assert_response :success
  end

  test "should get new_cover" do
    get covers_new_cover_url
    assert_response :success
  end

  test "should get not_found" do
    get covers_not_found_url
    assert_response :success
  end

  test "should get add_manually" do
    get covers_add_manually_url
    assert_response :success
  end

  test "should get load_cover" do
    get covers_load_cover_url
    assert_response :success
  end

  test "should get cover_upload" do
    get covers_cover_upload_url
    assert_response :success
  end

  test "should get mark_not_found" do
    get covers_mark_not_found_url
    assert_response :success
  end

end
