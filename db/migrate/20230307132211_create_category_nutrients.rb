class CreateCategoryNutrients < ActiveRecord::Migration[7.0]
  def change
    create_table :category_nutrients do |t|
      t.integer :min_score
      t.integer :max_score
      t.references :category, null: false, foreign_key: true
      t.references :nutrient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
