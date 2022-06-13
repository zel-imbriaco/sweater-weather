FactoryBot.define do
  factory :book do
    isbn { [Faker::Number.number(digits: 10), Faker::Number.number(digits: 13)] }
    subject { Faker::Book.genre }
    title { Faker::Book.title }
    author { Faker::Book.author }
    publisher { Faker::Book.publisher }
  end
end