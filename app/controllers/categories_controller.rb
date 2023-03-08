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
    # params["cat1q1"] => => "c=1q=1a=1s=1"
    raise

  end

end
