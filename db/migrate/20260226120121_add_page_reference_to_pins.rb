class AddPageReferenceToPins < ActiveRecord::Migration[8.1]
  def change
    add_reference :pins, :page, null: true, foreign_key: true
  end
end
