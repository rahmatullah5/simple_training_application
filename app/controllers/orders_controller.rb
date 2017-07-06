class OrdersController < InheritedResources::Base
  include CurrentCart
  before_action :set_cart
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :authenticate_user!
  protect_from_forgery except: [:hook]

  def index
    @line_items = @cart.line_items.includes(:product , product: [:product_images])
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    if @order.save
      send_user_notifcation(@order,@cart,current_user.email)
      redirect_to @order.paypal_url(@cart,@order,orders_path(@order))
    else
      render :new
    end
  end

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
  def send_user_notifcation(order,cart,email)
    HardWorker.perform_async(order,cart,email)
  end

  def ensure_cart_isnt_empty
    if @cart.line_items.empty?
      redirect_to root_path, notice: 'Your cart is empty'
    end
  end

  def order_params
    params.require(:order).permit(:name, :address, :email, :telephone, :user_id)
  end
end
