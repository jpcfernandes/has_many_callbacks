class AfterSaveOnDirectAssociation::BookInventoryEntry < BookInventoryEntry
  belongs_to :library,
             :class_name => 'AfterSaveOnDirectAssociation::Library',
             :inverse_of => :book_inventory_entries
  belongs_to :book,
             :class_name => 'AfterSaveOnDirectAssociation::Book'
end
