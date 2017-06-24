class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      has_many :line_items, dependent: :destroy
      t.timestamps
    end
  end
end
