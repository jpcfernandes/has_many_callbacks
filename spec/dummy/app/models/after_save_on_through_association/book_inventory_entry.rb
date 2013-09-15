class AfterSaveOnThroughAssociation::BookInventoryEntry < BookInventoryEntry
  belongs_to :library,
             :class_name => 'AfterSaveOnThroughAssociation::Library'

  belongs_to :book,
             :class_name => 'AfterSaveOnThroughAssociation::Book'
end
