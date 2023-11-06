FactoryBot.define do
  factory :item do
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/無題.jpg'), filename: 'test_image.png')
    end

    name { Faker::Lorem.word }
    explanation { Faker::Lorem.paragraph }
    category_id { 2 } # 適切な値に置き換えてください
    condition_id { 2 } # 適切な値に置き換えてください
    charge_id { 2 } # 適切な値に置き換えてください
    region_id { 2 } # 適切な値に置き換えてください
    number_of_day_id { 2 } # 適切な値に置き換えてください
    price { 1000 } # 適切な値に置き換えてください
  end
end
