require 'faker'

FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Date.forward(days: 365).strftime('%m/%y') } # 1 year in future
    result { ["success", "failed"].sample } 
    association :invoice
  end
end