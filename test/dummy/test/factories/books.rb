# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    name  { Faker::Movie.title }
    service_id 'asdf'
  end
end
