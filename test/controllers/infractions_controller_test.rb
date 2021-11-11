require 'test_helper'

class InfractionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @infraction = infractions(:one)
  end

  test "should get index" do
    get infractions_url
    assert_response :success
  end

  test "should get new" do
    get new_infraction_url
    assert_response :success
  end

  test "should create infraction" do
    assert_difference('Infraction.count') do
      post infractions_url, params: { infraction: { description: @infraction.description, first_offence: @infraction.first_offence, second_offence: @infraction.second_offence, subsiquent_offence: @infraction.subsiquent_offence, track: @infraction.track } }
    end

    assert_redirected_to infraction_url(Infraction.last)
  end

  test "should show infraction" do
    get infraction_url(@infraction)
    assert_response :success
  end

  test "should get edit" do
    get edit_infraction_url(@infraction)
    assert_response :success
  end

  test "should update infraction" do
    patch infraction_url(@infraction), params: { infraction: { description: @infraction.description, first_offence: @infraction.first_offence, second_offence: @infraction.second_offence, subsiquent_offence: @infraction.subsiquent_offence, track: @infraction.track } }
    assert_redirected_to infraction_url(@infraction)
  end

  test "should destroy infraction" do
    assert_difference('Infraction.count', -1) do
      delete infraction_url(@infraction)
    end

    assert_redirected_to infractions_url
  end
end
