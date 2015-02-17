require 'test_helper'

class BooksControllerTest < ActionController::TestCase

  def setup
    WebMock.stub_request(:any, /.*/).
    to_return(
        :status   => 200,
        :body     => "{}"
    )
    @no_of_books = 5
    create_list :book, @no_of_books
  end

  test "index" do
    get :index
    assert_response :success, 'it should return successfully'
    assert_equal @no_of_books, assigns(:books).count, "it should retrieve #{@no_of_books} books"
  end

  test "index with multiple params" do
    get :index
    expected_surrogate_keys = 'books books/1 books/2 books/3 books/4 books/5'

    assert_equal expected_surrogate_keys, response.headers['Surrogate-Key'], 'surrogate keys returned'
  end

  test "show" do
    expected_id = 1
    get :show, {:id => expected_id}
    assert_response :success, 'it should return successfully'
    assert_not_nil assigns(:book), '@book should not be nil'
    assert_instance_of Book, assigns(:book), 'it should be an instance of a book'
    assert_equal expected_id, assigns(:book).id, 'book.id should be the expected id'
    assert_equal "books/#{expected_id}", response.headers['Surrogate-Key'], "surrogate key for book"
  end

  test "create" do
    expected_name = 'newly-created-book'
    assert_difference('Book.count') do
      post :create, :book => {'name' => expected_name}
    end
  end
end
