class ResultsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :create]

  def index
    # this method is used when quiz_type == "multi_categories"

    quiz = Quiz.last
    @categories = []
    @categories_nutrients = []
    quiz.categories.each do |category_name|
      category = Category.find_by(name: category_name)
      @categories << category
      result = category.results.find_by(quiz_id: quiz.id)
      @categories_nutrients << category_nutrient_ids(result)
    end
  end

  def show
    # this method is used when quiz_type == "single_category"
    # cat_nutrients = CategoryNutrient.all
    # params[:id] = id of the result
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
      # @result.update(user_params)
      # redirect_to basket_path(@result.id)
    else
      # user has not logged in
      redirect_back(fallback_location: categories_path)
    end
  end

  def create
    # THIS METHOD REPLACES the categories/create method which was designed for single category quizzes
    # copied from the Categories/#create where it should not stay when we implement multi categories quiz
    # gets the results from the questions form
    # params["cat[:id]q[:id]"] => score for this category_id/question_id, in string format
    if params[:category_id]
      @category = Category.find(params[:category_id].to_i)
      @questions = @category.questions
      @max_category_score = 0
      @category_score = 0
      @questions.each do |question|
        @category_score += params["cat#{params[:category_id]}q#{question.id}"].to_i
        max_question_score = question.answers.map{ |answer| answer.score }.max
        @max_category_score += max_question_score
      end

      user_to_attach = current_user || User.find_by(first_name: "Crash", last_name: "Dummy")
      quiz_id = params[:quiz_id].to_i

      #create result
      @category_result = Result.create!(
        total_score: @category_score,
        max_score: @max_category_score,
        user_id: user_to_attach.id,
        category_id: @category.id,
        quiz_id: quiz_id
      )

      # show the results
      # redirect_to results_path(quiz_type: :multi_categories) if params[:last_quiz] == "true"
      redirect_to results_path if params[:last_quiz] == "true"
    end
  end

  def basket
    @result = Result.find(params[:id])
    @user = current_user
    #display of recommended nutrients or supplements and checkout
  end

  private

  def user_params
    params.require(:result).permit(:user_id, :max_score, :total_score, :quiz_id)
  end

  def category_nutrient_ids(result)
    # could these 3 lines be replaced with: @category = result.category ?
    result_score = result.total_score
    cat_id = result.category_id
    @category = Category.find(cat_id)

    nutrient_arr = CategoryNutrient.where(category_id: @category.id).where("min_score <= ?", result_score).where("max_score >= ?", result_score)
    nutrient_arr.map { |element| element.nutrient_id }
  end
end
