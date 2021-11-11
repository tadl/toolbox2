require "application_system_test_case"

class InfractionsTest < ApplicationSystemTestCase
  setup do
    @infraction = infractions(:one)
  end

  test "visiting the index" do
    visit infractions_url
    assert_selector "h1", text: "Infractions"
  end

  test "creating a Infraction" do
    visit infractions_url
    click_on "New Infraction"

    fill_in "Description", with: @infraction.description
    fill_in "First offence", with: @infraction.first_offence
    fill_in "Second offence", with: @infraction.second_offence
    fill_in "Subsiquent offence", with: @infraction.subsiquent_offence
    fill_in "Track", with: @infraction.track
    click_on "Create Infraction"

    assert_text "Infraction was successfully created"
    click_on "Back"
  end

  test "updating a Infraction" do
    visit infractions_url
    click_on "Edit", match: :first

    fill_in "Description", with: @infraction.description
    fill_in "First offence", with: @infraction.first_offence
    fill_in "Second offence", with: @infraction.second_offence
    fill_in "Subsiquent offence", with: @infraction.subsiquent_offence
    fill_in "Track", with: @infraction.track
    click_on "Update Infraction"

    assert_text "Infraction was successfully updated"
    click_on "Back"
  end

  test "destroying a Infraction" do
    visit infractions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Infraction was successfully destroyed"
  end
end
