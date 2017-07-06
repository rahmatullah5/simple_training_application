class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  serialize :notification_params, Hash
  require 'money'
  Money.add_rate("USD", "IDR", 0.013250)

  def paypal_url(cart,order,return_path)
    @cart = cart
    @order = order
    @total = Money.us_dollar(@cart.total_price).exchange_to("IDR")
    values = {
      business: "merchant@rahmat.com",
      cmd: "_xclick",
      upload: 1,
      return: "#{Rails.application.secrets.app_host}",
      invoice: "#{@order.id}",
      amount: "#{@total}",
      item_name: "Please Check Your Email For Detail All Of Your Order",
      item_number: "#{@cart.total_product}",
      quantity: "1",
      notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_products
    line_items.sum(:quantity)
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
