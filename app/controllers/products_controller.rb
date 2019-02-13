class ProductsController < ApplicationController
  before_action :authenticate_user!
  def index
    @products = Product.where(nil)
    if params[:only_user]
      @products = current_user.products
    else
      @products = @products.all
    end
    @products = @products.where(params[:status]) if params[:status]
  end

  def new
    @product = Product.new
  end

  def show
    @products = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    begin
      @product = current_user.products.build(product_params)
      @product.save!
      flash[:success] = "Successfully Added new Product"
    rescue => e
      flash[:danger] = e.message
    end
  end

  def update
    begin
      @products = Product.find(params[:id])
      @products.update_attributes!(product_params)
      flash[:notice] = "Update was successfully!"
    rescue => e
      flash[:danger] = e.message
    end
  end

  def destroy
    @products = Product.find(params[:id])
    @products.destroy
  end

  private
  def product_params
    params.require(:product).permit(:name, :price ,:status, :quantity)
  end
end
