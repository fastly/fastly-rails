require_relative '../../test_helper'

describe 'ActionController::API' do
  before { skip unless defined?(ActionController::API) }

  let(:controller) { Class.new(ActionController::API) }

  it 'adds control modules' do
    assert_includes controller.ancestors, FastlyRails::SurrogateKeyHeaders
    assert_includes controller.ancestors, FastlyRails::CacheControlHeaders
  end
end
