class ProductsController < ApplicationController
  before_action :authorize

  def index
    @products = Product.all
    render :index
  end

  def new
    @product = Product.new
    render :new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product Successfully Created"
      redirect_to products_path
    else
      flash[:notice] = "Product Creation Failed"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id].to_i)
    render :edit
  end

  def show
    @product = Product.find(params[:id].to_i)
    render :show
  end

  def update
    @product = Product.find(params[:id].to_i)
    if @product.update(product_params)
      flash[:notice] = "Product Successfully Updated"
      redirect_to products_path
    else
      flash[:notice] = "Product Failed to Update"
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id].to_i)
    @product.destroy
    flash[:notice] = "#{@product.name} was Deleted"
    redirect_to products_path
  end

  def most
    if Product.most_reviews.any?
      Product.most_reviews.each do |product|
        @product = product
      end
    end
    render :show
  end

  def recent
    @products = Product.three_recent
    render :recent
  end

  def usa
    @products = Product.usa_made
    render :usa
  end

  private
  def product_params
    params.require(:product).permit(:name, :cost, :country_of_origin)
  end

end
