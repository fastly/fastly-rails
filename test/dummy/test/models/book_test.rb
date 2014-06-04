require 'test_helper'

# class BookTest < ActiveSupport::TestCase
#   test "the truth" do
#     assert true
#   end
# end

describe Book do

  let (:book) { create :book, id: 1 }

  it "should have Fastly::SurrogateKey instance methods" do

    [:record_key, :table_key, :purge, :purge_all].each do |method|
      assert_respond_to book, method
    end

  end

  it "should have Fastly::SurrogateKey class methods" do

    [:table_key, :purge_all].each do |method|
      assert_respond_to Book, method
    end

  end

  it "should have a record_key of books/1" do
    assert_equal 'books/1', book.record_key
  end

  it "should have a table_key that returns its table name" do
    assert_equal 'books', book.table_key
  end

  it "should have class.table_key and instance.table_key that are equivalent" do
    assert_equal Book.table_key, book.table_key
  end

  describe 'service_id' do
    before do
      FastlyRails.configuration.service_id = 'someserviceid'
    end

    it 'should have class.service_id' do
      assert_respond_to Book, :service_id
    end

    it 'should have instance.service_id' do
      assert_respond_to book, :service_id
    end

    it 'should be class.service_id == instance.service_id' do
      assert_equal Book.service_id, book.service_id
    end

    after do
      FastlyRails.configuration.service_id = nil
    end
  end

end
