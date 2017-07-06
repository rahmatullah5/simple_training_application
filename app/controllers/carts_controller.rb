class CartsController < InheritedResources::Base
  include CurrentCart
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :authenticate_user!

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path,
      notice: 'Your cart is currently empty' }
      format.json { head :no_content }
    end
  end

  private
  def cart_params
    params.require(:cart).permit()
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to store_index_url, notice: 'Invalid cart'
  end
end
