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

  def create
    # THIS METHOD IS TO BE BE REMOVED when we launch multi category quiz:
    # this code is only accessed through the single category quiz
    # ALSO: When removed, the categories/create route should be deleted
    # AND :create removed from the skip_before_action list at the top of this controller

    # This method gets the results from the questions form
    # params["cat[:id]q[:id]"] => score for this category_id/question_id, in string format
    # Needs a dummy Quiz (with quiz.categories = ["dummy quiz"]) in the Quiz database to work.
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
      # need a dummy quiz for old version (one category quiz) to work
      # to be created manually or through the seeds if we keep the single category quiz user story
      quizz_id = Quiz.find_by(categories: ["dummy quiz"]).id

      #create result
      @category_result = Result.create!(
        total_score: @category_score,
        max_score: @max_category_score,
        user_id: user_to_attach.id,
        category_id: @category.id,
        quiz_id: quizz_id
      )

      # show results
      # redirect_to result_path(@category_result.id, quiz_type: :single_category)
      redirect_to result_path(@category_result.id)
    end
  end
end
