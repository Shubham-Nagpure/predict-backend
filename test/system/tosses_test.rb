require "application_system_test_case"

class TossesTest < ApplicationSystemTestCase
  setup do
    @toss = tosses(:one)
  end

  test "visiting the index" do
    visit tosses_url
    assert_selector "h1", text: "Tosses"
  end

  test "should create toss" do
    visit tosses_url
    click_on "New toss"

    fill_in "Team one", with: @toss.team_one_id
    fill_in "Team two", with: @toss.team_two_id
    fill_in "Timing", with: @toss.timing
    fill_in "Title", with: @toss.title
    click_on "Create Toss"

    assert_text "Toss was successfully created"
    click_on "Back"
  end

  test "should update Toss" do
    visit toss_url(@toss)
    click_on "Edit this toss", match: :first

    fill_in "Team one", with: @toss.team_one_id
    fill_in "Team two", with: @toss.team_two_id
    fill_in "Timing", with: @toss.timing.to_s
    fill_in "Title", with: @toss.title
    click_on "Update Toss"

    assert_text "Toss was successfully updated"
    click_on "Back"
  end

  test "should destroy Toss" do
    visit toss_url(@toss)
    accept_confirm { click_on "Destroy this toss", match: :first }

    assert_text "Toss was successfully destroyed"
  end
end
