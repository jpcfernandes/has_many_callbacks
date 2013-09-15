class Library < ActiveRecord::Base
  validates :name, :presence => true

  before_validation do
    self.inventory_count = 0 if inventory_count.nil?
    self.award_count = 0 if award_count.nil?
  end
end
