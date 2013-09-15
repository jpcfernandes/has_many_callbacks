class AfterSaveOnDirectAssociation::Book < Book
  has_many :book_inventory_entries,
           :class_name => 'AfterSaveOnDirectAssociation::BookInventoryEntry'
end
