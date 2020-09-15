require "application_system_test_case"

class StatsTest < ApplicationSystemTestCase
  setup do
    @stat = stats(:one)
  end

  test "visiting the index" do
    visit stats_url
    assert_selector "h1", text: "Stats"
  end

  test "creating a Stat" do
    visit stats_url
    click_on "New Stat"

    fill_in "Code", with: @stat.code
    fill_in "End date", with: @stat.end_date
    fill_in "Group name", with: @stat.group_name
    fill_in "Name", with: @stat.name
    fill_in "Start date", with: @stat.start_date
    click_on "Create Stat"

    assert_text "Stat was successfully created"
    click_on "Back"
  end

  test "updating a Stat" do
    visit stats_url
    click_on "Edit", match: :first

    fill_in "Code", with: @stat.code
    fill_in "End date", with: @stat.end_date
    fill_in "Group name", with: @stat.group_name
    fill_in "Name", with: @stat.name
    fill_in "Start date", with: @stat.start_date
    click_on "Update Stat"

    assert_text "Stat was successfully updated"
    click_on "Back"
  end

  test "destroying a Stat" do
    visit stats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stat was successfully destroyed"
  end
end
