class CreateBookInventoryEntries < ActiveRecord::Migration
  def change
    create_table :book_inventory_entries do |t|
      t.string :status
      t.datetime :added_at
      t.datetime :removed_at
      t.references :book
      t.references :library
      t.timestamps
    end
  end
end
