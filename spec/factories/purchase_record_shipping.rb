FactoryBot.define do
  factory :purchase_record_shipping do
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    region_id { Faker::Number.between(from: 2, to: 48) }
    city { '東京都文京区' }
    house_number { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    telephone { Faker::Number.number(digits: rand(10..11)) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
