class Library < ActiveRecord::Base
  has_many :book_inventory_entries
  has_many :books, :through => :book_inventory_entries

  validates :name, :presence => true

  def available_exemplar_count(book)
    book_inventory_entries.where(:book_id => book.is_a?(Integer) ? book : book.id).count
  end
end
