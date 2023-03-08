class CategoriesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show, :create]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @questions = @category.questions
    @results = params[:result]
  end

  def create
    #gest the results from the questions form
    # params["cat[:id]q[:id]"] => score for this category_id/question_id, in string format
    @category = Category.find(params[:category].to_i)
    @questions = @category.questions
    @max_category_score = 0
    @category_score = 0
    @questions.each do |question|
      @category_score += params["cat#{params[:category]}q#{question.id}"].to_i
      max_question_score = question.answers.map{|answer| answer.score}.max
      @max_category_score += max_question_score
    end
    #store in dummy_user
    dummy_user = User.find(1)
    category_result = Result.new(
      total_score: @category_score,
      max_score: @max_category_score
    )
    category_result.category = @category
    raise
    #check @max_category_score against nutrients [min_score , max_score]
    # in private method?
    # redirect_to next category
  end
end
