class ProductsController < ApplicationController
  #load_and_authorize_resource
  include CurrentCart
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :catalog
  before_action :authenticate_user!, except: :catalog
  before_action :set_cart, only: [:show, :edit, :update, :destroy , :catalog , :checkout , :checkout_form]

  def index
    @products = Product.all.page(params[:page])
  end

  def show; end

  def catalog
    @products = Product.includes(:product_images).all.page(params[:page])
    @line_items = @cart.line_items.includes([:product])
  end

  def checkout; end

  def checkout_form; end

  def new
    redirect_user
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully created.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, product_images_attributes: [:id, :name, :description, :image, :_destroy])
  end
end
