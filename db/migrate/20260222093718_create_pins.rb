class CreatePins < ActiveRecord::Migration[8.0]
  def change
    create_table :pins do |t|
      t.references :document, null: false, foreign_key: true
      t.float :x_coordinate
      t.float :y_coordinate
      t.integer :marker_number
      t.text :body

      t.timestamps
    end
  end
end
