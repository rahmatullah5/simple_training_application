# require 'elasticsearch/model'
class Product < ApplicationRecord
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  searchkick text_start: [:name]
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  has_many :product_images, dependent: :destroy
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  accepts_nested_attributes_for :product_images, reject_if: :all_blank, allow_destroy: true

  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
