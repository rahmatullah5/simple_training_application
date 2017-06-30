class OrdersController < InheritedResources::Base
  include CurrentCart
  before_action :set_cart
  before_action :ensure_cart_isnt_empty, only: :new

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    # respond_to do |format|
    if @order.save
      redirect_to @order.paypal_url(orders_path(@order))
      # Cart.destroy(session[:cart_id])
      # session[:cart_id] = nil
      # format.html { redirect_to root_path, notice:
      # 'Thank you for your orde Please Check Your Email.' }
      # format.json { render :show, status: :created,
      # location: @order }
    else
      # format.html { render :new }
      # format.json { render json: @order.errors,
      # status: :unprocessable_entity }
    end
    # end
  end
  def express_checkout
    response = EXPRESS_GATEWAY.setup_purchase(YOUR_TOTAL_AMOUNT_IN_CENTS,
      ip: request.remote_ip,
      return_url: YOUR_RETURN_URL_,
      cancel_return_url: YOUR_CANCEL_RETURL_URL,
      currency: "USD",
      allow_guest_checkout: true,
      items: [{name: "Order", description: "Order description", quantity: "1", amount: AMOUNT_IN_CENTS}]
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  protect_from_forgery except: [:hook]
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @order = Order.find params[:invoice]
      @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end
  private
  def ensure_cart_isnt_empty
    if @cart.line_items.empty?
      redirect_to root_path, notice: 'Your cart is empty'
    end
  end

  def order_params
    params.require(:order).permit(:name, :address, :email, :telephone, :user_id)
  end
end
