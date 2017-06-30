class AddParamsIpExprressTokenExpresssPayerIdViolationIdatToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :ip, :string
    add_column :orders, :express_token, :string
    add_column :orders, :express_payer_id , :string
    add_column :orders, :violation_id, :string
  end
end
