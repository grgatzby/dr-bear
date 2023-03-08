class ResultsController < ApplicationController
  def index

  end

  def show
    cat_nutrients = CategoryNutrient.all
    result = result.find()
    cat_nutrients.where(category_id: result.category_id).nutrients


    &&
    cat_nutrients.where(min_score:  result.total_score) &&
    cat_nutrients.where(max_score:  result.total_score) &&


    @cat_nutri.each do |element|
      nutrient = []
      if element.category_id == result.category_id
        nutrient << element.nutrient_id
      end



  end

end
