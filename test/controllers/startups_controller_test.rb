require "test_helper"

class StartupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get startups_index_url
    assert_response :success
  end

  test "should get show" do
    get startups_show_url
    assert_response :success
  end

  test "should get new" do
    get startups_new_url
    assert_response :success
  end

  test "should get create" do
    get startups_create_url
    assert_response :success
  end

  test "should get edit" do
    get startups_edit_url
    assert_response :success
  end

  test "should get update" do
    get startups_update_url
    assert_response :success
  end

  test "should get destroy" do
    get startups_destroy_url
    assert_response :success
  end
end
