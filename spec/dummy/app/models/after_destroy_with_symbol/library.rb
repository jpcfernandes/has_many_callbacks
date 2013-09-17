class AfterDestroyWithSymbol::Library < ::Library
  has_many :book_inventory_entries,
           :inverse_of => :library,
           :class_name => 'AfterDestroyWithSymbol::BookInventoryEntry',
           :after_destroy => :update_inventory_count

  has_many :books,
           :through => :book_inventory_entries,
           :inverse_of => :libraries,
           :class_name => 'AfterDestroyWithSymbol::Book',
           :after_destroy => :update_award_count

  private

  def update_inventory_count(book_inventory_entry)
    update_attributes(:inventory_count => inventory_count - 1)
  end

  def update_award_count(book)
    update_attributes(:award_count => award_count - book.award_count)
  end
end
