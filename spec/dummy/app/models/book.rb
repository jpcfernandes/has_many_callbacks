class Book < ActiveRecord::Base
  validates :title, :presence => true, :uniqueness => true

  before_validation do
    self.award_count ||= 0
  end

end
