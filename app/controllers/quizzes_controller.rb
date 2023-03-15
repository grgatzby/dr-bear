class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :new, :create]

  def show
    @quiz = Quiz.find(params[:id])
    @results = @quiz.categories.map { Result.new }
  end

  def new
    @quiz = Quiz.new
    @categories = Category.all
  end

  def create
    @quiz = Quiz.new(quiz_params)
    # replaces @quiz.categories with an array of selected category names
    @quiz.categories = []
    categories = Category.all
    categories.each do |category|
      @quiz.categories.push(category.name) if params["quiz"]["categories"].include?(category.id.to_s)
    end

    @quiz.save
    # goes to quizzes show view
    redirect_to quiz_path(@quiz)
  end

  private

  def quiz_params
    params.require(:quiz).permit(categories: [])
  end
end
