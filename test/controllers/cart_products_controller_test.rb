require 'test_helper'

class CartProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get cart_products_update_url
    assert_response :success
  end

end
