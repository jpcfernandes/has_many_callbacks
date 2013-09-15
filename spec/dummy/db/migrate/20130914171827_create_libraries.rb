class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :name
      t.integer :book_count
      t.integer :page_count
      t.integer :inventory_count
      t.timestamps
    end
  end
end
