require "test_helper"

class DocumentosControllerTest < ActionDispatch::IntegrationTest
  test "should get protocolo" do
    get documentos_protocolo_url
    assert_response :success
  end

  test "should get convenio" do
    get documentos_convenio_url
    assert_response :success
  end
end
