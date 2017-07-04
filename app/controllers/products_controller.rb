class ProductsController < ApplicationController
  #load_and_authorize_resource
  include CurrentCart
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :catalog
  before_action :authenticate_user!, except: :catalog
  before_action :set_cart, only: [:show, :edit, :update, :destroy , :catalog , :checkout , :checkout_form]

  # GET /products
  # GET /products.json
  def index
    # @products = Product.order(:name).page params[:page]
    #@cart = Cart.find(session[:cart_id])
    @products = Product.all.page(params[:page])#.per(1)
    #@users = Product.order(:name).page params[:page]
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end
  #
  def catalog
    #@cart = current_cart
    #@cart = Cart.find(session[:cart_id]) 
    @user = current_user
    @products = Product.all.page(params[:page])
  end

  def checkout
  end

  def checkout_form
  end
  # GET /products/new
  def new
    redirect_user
    @product = Product.new
  end

  # GET /products/1/edit
  def edit

  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    #@user = current_user
    #UserMailer.sample_email(@user).deliver
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

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        # format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully created.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :description, :price, product_images_attributes: [:id, :name, :description, :image, :_destroy])
  end

  def redirect_user()
    user = User.new
    if user.present?
      redirect_to root_path, notice: "You Can'n Acces This Page"
    end
    # unless current_user.role.eql? "basic"
    #
    # end
  end


end
