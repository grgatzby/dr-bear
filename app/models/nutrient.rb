class Nutrient < ApplicationRecord
  has_many :category_nutrients
  has_many :categories, through: :category_nutrients
end
