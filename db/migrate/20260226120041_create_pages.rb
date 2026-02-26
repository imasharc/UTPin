class CreatePages < ActiveRecord::Migration[8.1]
  def change
    create_table :pages do |t|
      t.references :document, null: false, foreign_key: true
      t.string :image_url
      t.integer :position

      t.timestamps
    end
  end
end
