class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :create, :multishow]
  $all_cat_results = {}
  $show_params = {}

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @questions = @category.questions
    @results = params[:result]
    raise
    # render :show
    # redirect_to categories_path(params[:id])
    $show_params = params
  end

  def multishow
    @categories = Category.select{ |category| params[category.id.to_s] }
    current_params = params
    @categories.each do |cat|
      @category = cat
      cat_results = {}
      cat_results[:category_id] = @category.id
      cat_results[:category_name] = @category.name
      @questions = @category.questions
      params[:id] = @category.id
      # go to show page (this category quiz)
      show
      cat_results[:category_result] = $show_params[:result]
      raise
      @results = $show_params[:result]
      $all_cat_results [:category_id] = @results
    end
    # redirect_to category_path(@cat_id) unless params[:id]
  end

  def create
    #gets the results from the questions form
    # params["cat[:id]q[:id]"] => score for this category_id/question_id, in string format
    raise
    @categories = Category.all
    @categories.each do |cat|
      @cat_id = cat.id
      if params[@cat_id.to_s]
        @category = cat
        @questions = @category.questions
        @max_category_score = 0
        @category_score = 0
        @questions.each do |question|
          @category_score += params["cat#{params[:category]}q#{question.id}"].to_i
          max_question_score = question.answers.map{ |answer| answer.score }.max
          @max_category_score += max_question_score
        end
        # current user if logged in, dummy user if not
        user_to_attach = current_user || User.find_by(first_name: "Crash", last_name: "Dummy")
        @category_result = Result.create!(
          total_score: @category_score,
          max_score: @max_category_score,
          user_id: user_to_attach.id,
          category_id: @category.id
        )
      end
    end
    # show results
    redirect_to result_path(@category_result.id)
  end
end
