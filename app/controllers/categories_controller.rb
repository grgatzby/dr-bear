class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :create, :multishow]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @questions = @category.questions
    @results = params[:result]
  end

  def multishow
    @categories = Category.select { |category| params[category.id.to_s] }
    @categories.each do |cat|
      @category = cat
      @questions = @category.questions
      cat_results = {}
      cat_results[:category_id] = @category.id
      cat_results[:category_name] = @category.name
      @questions = @category.questions
      params[:id] = @category.id
      # go to show page (this category quiz)
    end
    # redirect_to category_path(@cat_id) unless params[:id]
    @results = params[:result]
  end

  def create
    #gets the results from the questions form
    # params["cat[:id]q[:id]"] => score for this category_id/question_id, in string format
    if params[:category]
      @category = Category.find(params[:category].to_i)
      @questions = @category.questions
      @max_category_score = 0
      @category_score = 0
      @questions.each do |question|
        @category_score += params["cat#{params[:category]}q#{question.id}"].to_i
        max_question_score = question.answers.map{ |answer| answer.score }.max
        @max_category_score += max_question_score
      end
      user_to_attach = current_user || User.find_by(first_name: "Crash", last_name: "Dummy")
      @category_result = Result.create!(
        total_score: @category_score,
        max_score: @max_category_score,
        user_id: user_to_attach.id,
        category_id: @category.id
      )
      # show results
      redirect_to result_path(@category_result.id)
    end
  end
end
