require "test_helper"

class EnlacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enlaces_index_url
    assert_response :success
  end
end
