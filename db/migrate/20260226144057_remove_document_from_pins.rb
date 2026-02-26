class RemoveDocumentFromPins < ActiveRecord::Migration[8.0]
  # 'up' is what happens when we run db:migrate
  def up
    # 1. Save the production data first!
    Document.all.each do |doc|
      if doc.image_url.present?
        puts "Migrating Document #{doc.id} in Production..."
        
        # Create the new page
        new_page = Page.create(document_id: doc.id, image_url: doc.image_url, position: 1)
        
        # Move all pins belonging to this document over to the new page
        Pin.where(document_id: doc.id).update_all(page_id: new_page.id)
      end
    end

    # 2. Now that the data is safely moved, delete the column!
    remove_reference :pins, :document, foreign_key: true
  end

  # 'down' is what happens if we ever need to rollback this migration
  def down
    add_reference :pins, :document, foreign_key: true
  end
end