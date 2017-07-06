class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_product
    line_items.sum(:quantity)
  end

  def add_product(product)
    current_item = line_items.find_or_initialize_by(product_id: product.id)
     current_item.quantity += 1 if current_item.persisted?
    current_item
  end
end
