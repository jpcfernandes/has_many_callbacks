require 'spec_helper'

describe HasManyCallbacks do
  context 'when after_save parameter is a symbol' do
    it 'should trigger execution of method passed through after_save parameter on direct associations' do
      @library = FactoryGirl.create(:library)

      lambda {
        @library.books << FactoryGirl.create(:book, :page_count => 100)
      }.should change { @library.reload.inventory_count }.from(0).to(1)
    end

  end

end
