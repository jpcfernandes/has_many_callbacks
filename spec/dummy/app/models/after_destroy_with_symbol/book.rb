class AfterDestroyWithSymbol::Book < Book
  has_many :book_inventory_entries,
           :class_name => 'AfterDestroyWithSymbol::BookInventoryEntry'

  has_many :libraries,
           :class_name => 'AfterDestroyWithSymbol::Library',
           :through => :book_inventory_entries
end
