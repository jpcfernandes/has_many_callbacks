require 'spec_helper'

describe HasManyCallbacks do
  context 'when after_save parameter is a proc' do
    it 'should trigger execution of method passed through after_save parameter on direct associations' do
      @library = AfterSaveOnDirectAssociation::Library.create(:name => 'National Library')
      lambda {
        @library.books << AfterSaveOnDirectAssociation::Book.create(:title => '1984')
      }.should change { @library.reload.inventory_count }.from(0).to(1)
    end

    it 'should trigger execution of method through after_save parameter on has_many :through associations' do
      @library = AfterSaveOnThroughAssociation::Library.create(:name => 'National Library')
      @library.books << (@book = AfterSaveOnThroughAssociation::Book.create(:title => '1984'))

      lambda {
        @book.update_attributes(:award_count => 1)
      }.should change { @library.reload.award_count }.from(0).to(1)
    end

  end

end
