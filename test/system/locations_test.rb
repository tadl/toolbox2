require "application_system_test_case"

class LocationsTest < ApplicationSystemTestCase
  setup do
    @location = locations(:one)
  end

  test "visiting the index" do
    visit locations_url
    assert_selector "h1", text: "Locations"
  end

  test "creating a Location" do
    visit locations_url
    click_on "New Location"

    fill_in "Address", with: @location.address
    fill_in "Citystatezip", with: @location.citystatezip
    fill_in "Email", with: @location.email
    fill_in "Friday", with: @location.friday
    fill_in "Fullname", with: @location.fullname
    fill_in "Image", with: @location.image
    fill_in "Monday", with: @location.monday
    fill_in "Phone", with: @location.phone
    fill_in "Saturday", with: @location.saturday
    fill_in "Shortname", with: @location.shortname
    fill_in "Sunday", with: @location.sunday
    fill_in "Thursday", with: @location.thursday
    fill_in "Tuesday", with: @location.tuesday
    fill_in "Wednesday", with: @location.wednesday
    click_on "Create Location"

    assert_text "Location was successfully created"
    click_on "Back"
  end

  test "updating a Location" do
    visit locations_url
    click_on "Edit", match: :first

    fill_in "Address", with: @location.address
    fill_in "Citystatezip", with: @location.citystatezip
    fill_in "Email", with: @location.email
    fill_in "Friday", with: @location.friday
    fill_in "Fullname", with: @location.fullname
    fill_in "Image", with: @location.image
    fill_in "Monday", with: @location.monday
    fill_in "Phone", with: @location.phone
    fill_in "Saturday", with: @location.saturday
    fill_in "Shortname", with: @location.shortname
    fill_in "Sunday", with: @location.sunday
    fill_in "Thursday", with: @location.thursday
    fill_in "Tuesday", with: @location.tuesday
    fill_in "Wednesday", with: @location.wednesday
    click_on "Update Location"

    assert_text "Location was successfully updated"
    click_on "Back"
  end

  test "destroying a Location" do
    visit locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Location was successfully destroyed"
  end
end