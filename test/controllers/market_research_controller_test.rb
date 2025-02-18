require "test_helper"

class MarketResearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get market_research_index_url
    assert_response :success
  end

  test "should get show" do
    get market_research_show_url
    assert_response :success
  end
end
