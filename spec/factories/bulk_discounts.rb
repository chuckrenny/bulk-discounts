require "faker"

FactoryBot.define do
  factory :bulk_discount do
    percentage_off { Faker::Number.between(from: 10, to: 50) } # Random % off between 10 - 50
    threshold { Faker::Number.between(from: 5, to: 20) } # Random minimum between 5 - 20
    association :merchant 
  end
end