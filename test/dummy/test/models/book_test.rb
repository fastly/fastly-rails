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

  describe 'fastly_service_identifier' do
    before do
      FastlyRails.configuration.service_id = 'some-service-id'
    end

    it 'is a class method' do
      assert_respond_to Book, :fastly_service_identifier
    end

    it 'is an instance method' do
      assert_respond_to book, :fastly_service_identifier
    end

    it 'is true that class.fastly_service_identifier == instance.fastly_service_identifier' do
      assert_equal Book.fastly_service_identifier, book.fastly_service_identifier
    end

    it 'does not equal the value of `service_id` on the model' do
      refute_equal book.service_id, book.fastly_service_identifier
    end

    after do
      FastlyRails.configuration.service_id = nil
    end
  end

end
