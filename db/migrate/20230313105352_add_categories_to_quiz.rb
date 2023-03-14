class AddCategoriesToQuiz < ActiveRecord::Migration[7.0]
  def change
    add_column :quizzes, :categories, :string, array: true, default: []
  end
end
