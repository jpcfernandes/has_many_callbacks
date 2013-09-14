class BookInventoryEntry < ActiveRecord::Base
  belongs_to :book
  belongs_to :library

  validates :book, :presence => true
  validates :library, :presence => true
end
