class RemoveWeightFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :weight, :integer
  end
end
