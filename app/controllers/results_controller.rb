class ResultsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
  end

  def show
    # cat_nutrients = CategoryNutrient.all
    @result = Result.find(params[:id])
    result_score = @result.total_score
    cat_id = @result.category_id
    @category = Category.find(cat_id)

    @nutrient = []
    nutrient_arr = CategoryNutrient.where(category_id: cat_id).where("min_score <= ?", result_score).where("max_score >= ?", result_score)
    nutrient_arr.each { |element| @nutrient << element.nutrient_id }
    if nutrient_arr.empty?
      flash[:notice] = "No nutrients needed."
      redirect_back(fallback_location: categories_path)
    end
  end

  def update
    @result = Result.find(params[:id])
    if current_user
      # user will have to login (or sign up) if not already logged in (to display pills bundles to buy)
      @user = current_user
      @result.update(user_id: @user.id)
      # @result.update(user_params)
      # redirect_to basket_path(@result.id)
    else
      # user has not logged in
      redirect_back(fallback_location: categories_path)
    end
  end

  def basket
    @result = Result.find(params[:id])
    @user = current_user
    #display of recommended nutrients or supplements and checkout
  end

  private

  def user_params
    params.require(:result).permit(:user_id)
  end
end
