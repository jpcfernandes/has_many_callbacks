class AfterDestroyWithSymbol::BookInventoryEntry < BookInventoryEntry
  belongs_to :library,
             :class_name => 'AfterDestroyWithSymbol::Library'

  belongs_to :book,
             :class_name => 'AfterDestroyWithSymbol::Book'
end
