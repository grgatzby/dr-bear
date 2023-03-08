class ResultsController < ApplicationController

  def index
  end

  def show
    raise
    cat_nutrients = CategoryNutrient.all
    result = category.result


    @cat_nutri.each do |element|
      nutrient = []

      if cat_nutrients.where(category_id: result.category_id) &&
         cat_nutrients.where(min_score: result.total_score) &&
         cat_nutrients.where(max_score: result.total_score)

         nutrient << element.nutrient_id
      end
    end
  end
end
