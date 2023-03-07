class Question < ApplicationRecord
  belongs_to :category
  has_many :answers

  validates :content, length: { minimum: 5 }
end
