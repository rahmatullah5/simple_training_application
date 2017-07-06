class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  def total_price
    product.price * quantity
  end

  def total_products
    puts "error"
  end
end
