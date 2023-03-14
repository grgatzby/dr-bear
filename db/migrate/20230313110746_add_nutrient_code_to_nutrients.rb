class AddNutrientCodeToNutrients < ActiveRecord::Migration[7.0]
  def change
    add_column :nutrients, :nutri_code, :string
  end
end
