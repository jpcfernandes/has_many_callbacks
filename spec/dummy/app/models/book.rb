class Book < ActiveRecord::Base
  #has_many :book_inventory_entries
  #has_many :libraries,
  #         :through => :book_inventory_entries,
  #         :inverse_of => :books

  validates :title, :presence => true, :uniqueness => true
end
