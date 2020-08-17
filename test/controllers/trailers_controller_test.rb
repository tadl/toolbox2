require 'test_helper'

class TrailersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trailers_index_url
    assert_response :success
  end

  test "should get verify" do
    get trailers_verify_url
    assert_response :success
  end

end
