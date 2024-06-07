require "test_helper"

class PeriodosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get periodos_index_url
    assert_response :success
  end
end
