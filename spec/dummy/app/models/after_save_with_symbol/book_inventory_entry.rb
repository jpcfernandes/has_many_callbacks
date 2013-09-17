class AfterSaveWithSymbol::BookInventoryEntry < BookInventoryEntry
  belongs_to :library,
             :class_name => 'AfterSaveWithSymbol::Library'

  belongs_to :book,
             :class_name => 'AfterSaveWithSymbol::Book'
end
