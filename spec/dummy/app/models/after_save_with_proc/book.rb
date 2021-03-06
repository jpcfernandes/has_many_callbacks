class AfterSaveWithProc::Book < Book
  has_many :book_inventory_entries,
           :class_name => 'AfterSaveWithProc::BookInventoryEntry'
  has_many :libraries,
           :class_name => 'AfterSaveWithProc::Library',
           :through => :book_inventory_entries
end
