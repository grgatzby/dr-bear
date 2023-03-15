class AddReferenceToResults < ActiveRecord::Migration[7.0]
  def change
    add_reference :results, :quiz, null: false, foreign_key: true
  end
end
