class AfterDestroyWithProc::Book < Book
  has_many :book_inventory_entries,
           :class_name => 'AfterDestroyWithProc::BookInventoryEntry'

  has_many :libraries,
           :class_name => 'AfterDestroyWithProc::Library',
           :through => :book_inventory_entries
end
