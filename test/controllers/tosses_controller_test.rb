require "test_helper"

class TossesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @toss = tosses(:one)
  end

  test "should get index" do
    get tosses_url
    assert_response :success
  end

  test "should get new" do
    get new_toss_url
    assert_response :success
  end

  test "should create toss" do
    assert_difference("Toss.count") do
      post tosses_url, params: { toss: { team_one_id: @toss.team_one_id, team_two_id: @toss.team_two_id, timing: @toss.timing, title: @toss.title } }
    end

    assert_redirected_to toss_url(Toss.last)
  end

  test "should show toss" do
    get toss_url(@toss)
    assert_response :success
  end

  test "should get edit" do
    get edit_toss_url(@toss)
    assert_response :success
  end

  test "should update toss" do
    patch toss_url(@toss), params: { toss: { team_one_id: @toss.team_one_id, team_two_id: @toss.team_two_id, timing: @toss.timing, title: @toss.title } }
    assert_redirected_to toss_url(@toss)
  end

  test "should destroy toss" do
    assert_difference("Toss.count", -1) do
      delete toss_url(@toss)
    end

    assert_redirected_to tosses_url
  end
end
