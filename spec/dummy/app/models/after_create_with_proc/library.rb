class AfterCreateWithProc::Library < ::Library
  has_many :book_inventory_entries,
           :inverse_of => :library,
           :class_name => 'AfterCreateWithProc::BookInventoryEntry',
           :after_create => lambda { |library, book_inventory_entry|
             library.update_attributes(:inventory_count => library.inventory_count + 1)
           }

  has_many :books,
           :through => :book_inventory_entries,
           :inverse_of => :libraries,
           :class_name => 'AfterCreateWithProc::Book',
           :after_create => lambda { |library, book|
             library.update_attributes(:award_count => library.award_count + book.award_count)
           }
end
