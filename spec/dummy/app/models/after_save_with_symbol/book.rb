class AfterSaveWithSymbol::Book < Book
  has_many :book_inventory_entries,
           :class_name => 'AfterSaveWithSymbol::BookInventoryEntry'
  has_many :libraries,
           :class_name => 'AfterSaveWithSymbol::Library',
           :through => :book_inventory_entries
end
