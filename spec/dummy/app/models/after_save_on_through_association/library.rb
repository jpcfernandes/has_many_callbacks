class AfterSaveOnThroughAssociation::Library < ::Library
  has_many :book_inventory_entries,
           :class_name => 'AfterSaveOnThroughAssociation::BookInventoryEntry'

  has_many :books,
           :through => :book_inventory_entries,
           :inverse_of => :libraries,
           :class_name => 'AfterSaveOnThroughAssociation::Book',
           :after_save => lambda { |library, book|
             library.update_attributes(:award_count => library.award_count + book.award_count)
           }
end
