class ResultsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :create ]

  require "json"
  require "rest-client"

  def index
    # THIS METHOD NOW REPLACES the results/#show method below
    # it is used for multi categories quizzes
    # start of FoodData Central API call
    query = "description:raw "
    data_source = "Foundation" # "Foundation" "SR Legacy" "Survey (FNDDS)"
    num_results = 200
    num_page = 1
    sort_by = "dataType.keyword" # "dataType.keyword"
    sort_order = "asc"  # "asc" "desc"
    all_words = "true"  # "true" "false"
    query_input = "query=#{query}&dataType=#{data_source}&pageSize=#{num_results}&pageNumber=#{num_page}&sortBy=#{sort_by}&sortOrder=#{sort_order}&requireAllWords=#{all_words}"
    base_url = "https://api.nal.usda.gov/fdc/v1/foods/search?api_key="
    api_key = "aspXTzPYagPtfEmDa8Sj6iCRFbAGSjKAH6Xm7cSl&"
    search_url = base_url + api_key + query_input
    search_results = RestClient.get(search_url, headers = {})
    @results = JSON.parse(search_results)
    @food_item = @results["foods"]

    # # API filtering for Food name with highest nutrient value
    # nutri = Nutrient.find(nutrient)
    # @name = []
    # @food_item.each do |food|
    #   food["foodNutrients"].each do |nutrient|
    #     if nutrient["nutrientNumber"] == nutri.nutri_code
    #       @name.push([food["description"], nutrient["value"]])
    #     end
    #   end
    # end

    # # sorting for Food with highest nutrient value
    # @sorted_names = @name.sort_by {|obj| obj [1]}
    # @result_name = @sorted_names.last(3).map {|obj| obj [0]}
    # @result_name.reverse!

    # # display name of food per nutrient
    # @result_name
    #   @result_name.each do |name|
    #     name = name.split(", ")
    #     name.delete_at(-1)
    #     @final_name = name.join(", ")
    # end

    # end of FoodData Central API call

    @quiz = Quiz.last
    category_from_quiz(@quiz)
  end

  def show
    # no longer used
    # THIS METHOD IS TO BE BE REMOVED when we launch multi category quiz
    # it is used for single category quizzes
    # nb: params[:id] = id of the result from the quiz
    @result = Result.find(params[:id])
    @category_nutrients = category_nutrient_ids(@result)
    if @category_nutrients.empty? && params[:quiz_type] == "single_category"
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
    else
      # user has not logged in
      redirect_back(fallback_location: categories_path)
    end
  end

  def create
    # THIS METHOD NOW REPLACES the categories/create method which was designed for single category quizzes
    # copied from the Categories/#create where it should not stay when we implement multi categories quiz
    # gets the results from the questions form
    # params["cat[:id]q[:id]"] => score for this category_id/question_id, in string format
    # assigns dummy user if not logged in
    user_to_attach = current_user || User.find_by(first_name: "Crash", last_name: "Dummy")
    quiz_id = params[:quiz_id].to_i
    quiz_categories_names = Quiz.find(quiz_id).categories
    quiz_categories_names.each do |category_name|
      category = Category.find_by(name: category_name)
      questions = category.questions
      max_category_score = 0
      category_score = 0
      questions.each do |question|
        if params["category#{category.id}question#{question.id}"]
          category_score += params["category#{category.id}question#{question.id}"].to_i
          max_question_score = question.answers.map{ |answer| answer.score }.max
          max_category_score += max_question_score
        end
      end
      # creates a Result instance for the category
      Result.create!(
        total_score: category_score,
        max_score: max_category_score,
        user_id: user_to_attach.id,
        category_id: category.id,
        quiz_id: quiz_id
      )
    end
    redirect_to results_path
  end

  def basket
    @quiz = Quiz.last
    category_from_quiz(@quiz)
    @user = current_user
    # TO DO (Ilan): display recommended nutrients for user to buy
  end

  private

  def user_params
    params.require(:result).permit(:user_id, :max_score, :total_score, :quiz_id)
  end

  def category_nutrient_ids(result)
    result_score = result.total_score
    cat_id = result.category_id

    @category = Category.find(cat_id)
    nutrient_arr = CategoryNutrient.where(category_id: @category.id).where("min_score <= ?", result_score).where("max_score >= ?", result_score)
    # nutrient_arr.map { |element| element.nutrient_id }
    nutrient_arr.map(&:nutrient_id)
  end

  def category_from_quiz(quiz)
    @categories = []
    @categories_nutrients = []
    quiz.categories.each do |category_name|
      category = Category.find_by(name: category_name)
      @categories << category
      result = category.results.find_by(quiz_id: quiz.id)
      @categories_nutrients << category_nutrient_ids(result)
    end
  end
end
