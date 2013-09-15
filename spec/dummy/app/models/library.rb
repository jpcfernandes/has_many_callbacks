class Library < ActiveRecord::Base
  has_many :book_inventory_entries,
           :inverse_of => :library,
           :after_save => lambda { |library|
             library.update_attributes(:inventory_count => (library.inventory_count || 0) + 1)
           }

  has_many :books,
           :through => :book_inventory_entries

  validates :name, :presence => true

  before_validation do
    self.inventory_count = 0 if inventory_count.nil?
    self.page_count = 0 if page_count.nil?
  end

  def available_exemplar_count(book)
    book_inventory_entries.where(:book_id => book.is_a?(Integer) ? book : book.id).count
  end
end
