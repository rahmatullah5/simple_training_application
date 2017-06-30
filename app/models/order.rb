class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  serialize :notification_params, Hash

  def paypal_url(return_path)
    values = {
      business: "merchant@rahmat.com",
      cmd: "_xclick",
      upload: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      amount: 1,
      item_name: "Rahmat Books",
      item_number: "10",
      quantity: '1',
      notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  def total_product
    line_items.to_a.sum { |item| item.quantity }
  end
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  def purchase
    response = EXPRESS_GATEWAY.purchase(order.total_amount_cents, express_purchase_options)
    cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def express_token=(token)
    self[:express_token] = token
    if new_record? && !token.blank?
      # you can dump details var if you need more info from buyer
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
    end
  end

  private

  def express_purchase_options
    {
      :ip => ip,
      :token => express_token,
      :payer_id => express_payer_id
    }
  end


end
