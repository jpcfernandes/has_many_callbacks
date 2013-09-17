class AfterSaveWithProc::BookInventoryEntry < BookInventoryEntry
  belongs_to :library,
             :class_name => 'AfterSaveWithProc::Library'

  belongs_to :book,
             :class_name => 'AfterSaveWithProc::Book'
end
