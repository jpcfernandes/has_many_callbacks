class AfterSaveWithProc::Library < ::Library
  has_many :book_inventory_entries,
           :inverse_of => :library,
           :class_name => 'AfterSaveWithProc::BookInventoryEntry',
           :after_save => lambda { |library, book_inventory_entry|
             library.update_attributes(:inventory_count => library.inventory_count + 1)
           }

  has_many :books,
           :through => :book_inventory_entries,
           :inverse_of => :libraries,
           :class_name => 'AfterSaveWithProc::Book',
           :after_save => lambda { |library, book|
             library.update_attributes(:award_count => library.award_count + book.award_count)
           }
end
