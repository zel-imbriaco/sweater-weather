FactoryBot.define do
  factory :book do
    isbn: [Faker::Number.number(digits: 10), Faker::Number.number(digits(13))]