require 'test_helper'

class FastlyHeadersTest < ActionDispatch::IntegrationTest

  test '/books index page should have fastly headers' do

    get '/books'
    assert_response :success

    assert !request.session_options[:skip].nil?
    assert_equal true, request.session_options[:skip]

    assert response.headers.key?('Cache-Control')
    assert_equal 'public, no-cache', response.headers['Cache-Control']

    assert response.headers.key?('Surrogate-Control')
    max_age = FastlyRails.configuration.max_age
    assert_equal "max-age=#{max_age}", response.headers['Surrogate-Control']
  end

  test '/books/:id show page should have fastly headers' do

    create :book, :id => 1

    get '/books/1'
    assert_response :success

    assert !request.session_options[:skip].nil?
    assert_equal true, request.session_options[:skip]

    assert response.headers.key?('Cache-Control')
    assert_equal 'public, no-cache', response.headers['Cache-Control']

    assert response.headers.key?('Surrogate-Control')
    max_age = FastlyRails.configuration.max_age
    assert_equal "max-age=#{max_age}", response.headers['Surrogate-Control']


  end

  test 'POST /books should not have fastly headers/ fastly header values' do

    assert_difference('Book.count') do
      post '/books', params: { book: { name: 'some new book' }}
    end

    assert_nil request.session_options[:skip]

    assert response.headers.key?('Cache-Control')
    assert_equal 'no-cache', response.headers['Cache-Control']

    assert !response.headers.key?('Surrogate-Control')

  end

  test 'PUT /books/:id should not have fastly headers/ fastly header values' do

    create :book, :id => 1, :name => 'some new book'

    put '/books/1', params: { id: 1, book: { 'name' => 'changed book' }}

    assert_equal 'changed book', Book.find(1).name

    assert_nil request.session_options[:skip]

    assert response.headers.key?('Cache-Control')
    assert_equal 'no-cache', response.headers['Cache-Control']

    assert !response.headers.key?('Surrogate-Control')
  end

  test 'DELETE /books/:id should not have fastly headers/ fastly header values' do
    create :book, :id => 1

    delete '/books/1'

    assert Book.where(:id => 1).empty?

    assert_nil request.session_options[:skip]

    assert response.headers.key?('Cache-Control')
    assert_equal 'no-cache', response.headers['Cache-Control']

    assert !response.headers.key?('Surrogate-Control')
  end
end
