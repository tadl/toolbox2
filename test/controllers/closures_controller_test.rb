require 'test_helper'

class ClosuresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get closures_index_url
    assert_response :success
  end

  test "should get new" do
    get closures_new_url
    assert_response :success
  end

  test "should get edit" do
    get closures_edit_url
    assert_response :success
  end

  test "should get save" do
    get closures_save_url
    assert_response :success
  end

  test "should get delete" do
    get closures_delete_url
    assert_response :success
  end

end
