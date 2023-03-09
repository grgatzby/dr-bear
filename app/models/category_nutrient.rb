class CategoryNutrient < ApplicationRecord
  belongs_to :category
  belongs_to :nutrient

end
