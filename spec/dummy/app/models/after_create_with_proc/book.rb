class AfterCreateWithProc::Book < Book
  has_many :book_inventory_entries,
           :class_name => 'AfterCreateWithProc::BookInventoryEntry'
  has_many :libraries,
           :class_name => 'AfterCreateWithProc::Library',
           :through => :book_inventory_entries
end
