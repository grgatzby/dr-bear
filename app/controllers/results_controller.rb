class ResultsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :create]

  def index
  end

  def show
    # cat_nutrients = CategoryNutrient.all
    # if quiz_type == "single_category"
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
    else
      #if quiz_type == "multi_categories"
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
    # Previous code, probably not used
    # @result = Result.new

    # moved from the Categories/#create where it should not be
    #gets the results from the questions form
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
      redirect_to result_path(@category_result.id, quiz_type: :multi_categories) if params[:last_quiz] == "true"
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
end
