class AfterSaveWithProc::BookInventoryEntry < BookInventoryEntry
  belongs_to :library,
             :class_name => 'AfterSaveWithProc::Library',
             :inverse_of => :book_inventory_entries

  belongs_to :book,
             :class_name => 'AfterSaveWithProc::Book'
end
