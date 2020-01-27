class ReviewsController < ApplicationController
  before_action :authorize
  def new
    @product = Product.find(params[:product_id].to_i)
    @review = @product.reviews.new
    render :new
  end

  def create
    @product = Product.find(params[:product_id].to_i)
    @review = @product.reviews.new(review_params)
    if @review.save
      flash[:notice] = "Review Successfully Created"
      redirect_to product_path(@product)
    else
      flash[:notice] = "Review Creation Failed"
      render :new
    end
  end

  def show
    @product = Product.find(params[:product_id].to_i)
    @review = Review.find(params[:id])
    render :show
  end

  def edit
    @product = Product.find(params[:product_id].to_i)
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "Review Successfully Updated"
      redirect_to product_review_path(@review.product)
    else
      flash[:notice] = "Review Failed to Update"
      @product = Product.find(params[:product_id].to_i)
      render :edit
      # redirect_back fallback_location {action: show, @review}
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "A Review for #{@review.product.name} was Deleted"
    redirect_to product_path(@review.product)
  end

  private
  def review_params
    params.require(:review).permit(:author, :content_body, :rating, :product_id)
  end

end
