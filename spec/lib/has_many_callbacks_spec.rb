require 'spec_helper'

describe HasManyCallbacks do
  shared_examples 'executes after save callback' do |options|
    test_mod = options[:when_calling]

    it "should trigger execution of after_save callback on direct association when passing #{test_mod.to_s.underscore.humanize.downcase}" do
      @library = test_mod::Library.create(:name => 'National Library')
      lambda {
        @library.books << test_mod::Book.create(:title => '1984')
      }.should change { @library.reload.inventory_count }.from(0).to(1)
    end

    it "should trigger execution of after_save callback on :through associations when passing #{test_mod.to_s.underscore.humanize.downcase}" do
      @library = test_mod::Library.create(:name => 'National Library')
      @library.books << (@book = test_mod::Book.create(:title => '1984'))

      @book.libraries.reload

      lambda {
        @book.update_attributes(:award_count => 3)
      }.should change { @library.reload.award_count }.from(0).to(3)
    end

    it "should trigger execution of after_save callback if inverse is also collection when passing #{test_mod.to_s.underscore.humanize.downcase}" do
      @library1 = test_mod::Library.create(:name => 'National Library')
      @library2 = test_mod::Library.create(:name => 'International Library')
      @book = test_mod::Book.create(:title => '1984')

      @library1.books << @book
      @library2.books << @book

      @book.libraries.reload

      lambda {
        @book.update_attributes(:award_count => 3)
      }.should change { [@library1.reload.award_count, @library2.reload.award_count] }.from([0, 0]).to([3, 3])
    end
  end

  shared_examples "executes after destroy callback" do |options|
    test_mod = options[:when_calling]
    before(:each) do
      @library = test_mod::Library.create(:name => 'National Library',
                                          :inventory_count => 1,
                                          :award_count => 3)
      @book = test_mod::Book.create(:title => '1984',
                                    :award_count => 3)
      @book_inventory_entry = test_mod::BookInventoryEntry.create(:book => @book,
                                                                  :library => @library)
    end

    it "should trigger execution of after_remove callback on direct association when passing #{test_mod.to_s.underscore.humanize.downcase}" do
      lambda {
        test_mod::BookInventoryEntry.where(:book_id => @book.id, :library_id => @library.id).first.destroy
      }.should change { @library.reload.inventory_count }.from(1).to(0)
    end
  end

  it_behaves_like 'executes after save callback',
                  :when_calling => AfterSaveWithProc

  it_behaves_like 'executes after save callback',
                  :when_calling => AfterSaveWithSymbol

  it_behaves_like 'executes after destroy callback',
                  :when_calling => AfterDestroyWithSymbol

  it_behaves_like 'executes after destroy callback',
                  :when_calling => AfterDestroyWithProc

end
