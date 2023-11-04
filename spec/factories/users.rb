FactoryBot.define do
  factory :user do
    nickname { 'てすと' }
    email { Faker::Internet.email }
    password { 'test12' }
    password_confirmation { password }
    family_name { '山田' }
    first_name { '太郎' }
    family_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birth_day { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
