class Category < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions
  has_many :category_nutrients, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :nutrients, through: :category_nutrients
end
