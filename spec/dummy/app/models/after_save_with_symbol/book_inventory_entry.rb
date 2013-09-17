class AfterSaveWithSymbol::BookInventoryEntry < BookInventoryEntry
  belongs_to :library,
             :class_name => 'AfterSaveWithSymbol::Library',
             :inverse_of => :book_inventory_entries

  belongs_to :book,
             :class_name => 'AfterSaveWithSymbol::Book'
end
