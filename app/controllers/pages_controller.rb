class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @questions = @category.questions
  end
end
