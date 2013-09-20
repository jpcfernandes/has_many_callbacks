class AfterCreateWithProc::BookInventoryEntry < BookInventoryEntry
  belongs_to :library,
             :class_name => 'AfterCreateWithProc::Library'

  belongs_to :book,
             :class_name => 'AfterCreateWithProc::Book'
end
