class AfterSaveOnDirectAssociation::Library < Library
  has_many :book_inventory_entries,
           :class_name => 'AfterSaveOnDirectAssociation::BookInventoryEntry',
           :inverse_of => :library,
           :after_save => lambda { |library, book_inventory_entry|
             library.update_attributes(:inventory_count => library.inventory_count + 1)
           }
  has_many :books,
           :through => :book_inventory_entries,
           :class_name => 'AfterSaveOnDirectAssociation::Book'
end
