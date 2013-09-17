class AfterDestroyWithSymbol::BookInventoryEntry < BookInventoryEntry
  belongs_to :library,
             :class_name => 'AfterDestroyWithSymbol::Library',
             :inverse_of => :book_inventory_entries

  belongs_to :book,
             :class_name => 'AfterDestroyWithSymbol::Book'

  after_save { |record| logger.info( "Contact #{record.id} was created." ) }
end
