class Result < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :quiz
end
