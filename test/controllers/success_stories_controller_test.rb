require "test_helper"

class SuccessStoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get success_stories_index_url
    assert_response :success
  end

  test "should get show" do
    get success_stories_show_url
    assert_response :success
  end

  test "should get new" do
    get success_stories_new_url
    assert_response :success
  end

  test "should get create" do
    get success_stories_create_url
    assert_response :success
  end

  test "should get edit" do
    get success_stories_edit_url
    assert_response :success
  end

  test "should get update" do
    get success_stories_update_url
    assert_response :success
  end

  test "should get destroy" do
    get success_stories_destroy_url
    assert_response :success
  end
end
