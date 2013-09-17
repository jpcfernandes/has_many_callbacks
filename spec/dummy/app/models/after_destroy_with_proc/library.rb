class AfterDestroyWithProc::Library < ::Library
  has_many :book_inventory_entries,
           :inverse_of => :library,
           :class_name => 'AfterDestroyWithProc::BookInventoryEntry',
           :after_destroy => lambda { |library, book_inventory_entry|
             library.update_attributes(:inventory_count => library.inventory_count - 1)
           }

  has_many :books,
           :through => :book_inventory_entries,
           :inverse_of => :libraries,
           :class_name => 'AfterDestroyWithProc::Book',
           :after_destroy => lambda { |library, book|
             library.update_attributes(:award_count => library.award_count - book.award_count)
           }
  private
end
