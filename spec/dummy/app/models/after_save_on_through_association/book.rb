class AfterSaveOnThroughAssociation::Book < Book
  has_many :book_inventory_entries,
           :class_name => 'AfterSaveOnThroughAssociation::BookInventoryEntry'
  has_many :libraries,
           :class_name => 'AfterSaveOnThroughAssociation::Library',
           :inverse_of => :books,
           :through => :book_inventory_entries
end
