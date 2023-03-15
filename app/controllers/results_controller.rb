class ResultsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  require "json"
  require "rest-client"

  def index
    # start of Results filtering based on result score
    @result = Result.find(3)
    result_score = @result.total_score
    cat_id = @result.category_id
    @category = Category.find(cat_id)

    @nutrient = []
    nutrient_arr = CategoryNutrient.where(category_id: cat_id).where("min_score <= ?", result_score).where("max_score >= ?", result_score)
    nutrient_arr.each { |element| @nutrient << element.nutrient_id }
    # end of Results filtering based on result score

  # start of FoodData Central API call
    query = "description:raw "
    data_source = "Foundation" # "Foundation" "SR Legacy" "Survey (FNDDS)"
    num_results = 200
    num_page = 1
    sort_by = "dataType.keyword"   # "dataType.keyword"
    sort_order = "asc"  # "asc" "desc"
    all_words = "true" #"true" "false"
    query_input = "query=#{query}&dataType=#{data_source}&pageSize=#{num_results}&pageNumber=#{num_page}&sortBy=#{sort_by}&sortOrder=#{sort_order}&requireAllWords=#{all_words}"
    base_url = "https://api.nal.usda.gov/fdc/v1/foods/search?api_key="
    api_key = "aspXTzPYagPtfEmDa8Sj6iCRFbAGSjKAH6Xm7cSl&"
    search_url = base_url+api_key+query_input
    search_results = RestClient.get(search_url, headers={})
    @results = JSON.parse(search_results)
    @food_item = @results["foods"]
  # end of FoodData Central API call



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
