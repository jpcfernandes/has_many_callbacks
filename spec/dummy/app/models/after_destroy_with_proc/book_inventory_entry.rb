class AfterDestroyWithProc::BookInventoryEntry < BookInventoryEntry
  belongs_to :library,
             :class_name => 'AfterDestroyWithProc::Library'

  belongs_to :book,
             :class_name => 'AfterDestroyWithProc::Book'

  after_save { |record| logger.info( "Contact #{record.id} was created." ) }
end
