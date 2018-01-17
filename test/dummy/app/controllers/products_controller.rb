class ProductsController < ApplicationController

  def index
  	@products = Product.all
  	respond_with @products
  end

  def show
  	@product = Product.find params[:id]
  	respond_with @product
  end

  def new
  	@product = Product.new product_params
  	respond_with @product
  end

  def create
  	@product = Product.create product_params
  	respond_with @product
  end

private

	def product_params
		params.fetch( :product, {} ).permit( :name, :description, :price )
	end

end
