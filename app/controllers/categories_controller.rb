class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :create]

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
    # params["cat1q1"] => score for this category/question, string format
    @category = Category.find(params[:category].to_i)
    @questions = @category.questions
    @max_category_score = 0
    @category_score = 0
    @questions.each do |question|
      @category_score += params["cat#{params[:category]}q#{question.id}"].to_i
      max_question_score = question.answers.map{|answer| answer.score}.max
      @max_category_score += max_question_score
    end
    #check @max_category_score against nutrients [min_score , max_score]
    # in private method?
    # redirect_to next category
  end
end
