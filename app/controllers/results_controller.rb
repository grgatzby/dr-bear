class ResultsController < ApplicationController

  def index
    cat_nutrients = CategoryNutrient.all
    result = Result.find(9)
    @category = Category.find(result.category_id)

    @nutrient = []
    cat_nutrients.where(category_id: result.category_id).where("min_score <= ?", result.total_score).where("max_score >= ?", result.total_score).each { |element| @nutrient << element.nutrient_id }


  end


  def show

  end
end
