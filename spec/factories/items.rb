FactoryBot.define do
  factory :item do
    # 画像のファイルパスを指定してアタッチ
    image do
      Rack::Test::UploadedFile.new(
        Rails.root.join('app', 'assets', 'images', 'furima-header02.png'), # 画像ファイルのパスを指定
        'image/jpeg' # 画像のコンテントタイプに合わせて変更
      )
    end

    name { Faker::Commerce.product_name }
    explanation { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 11) }
    condition_id { Faker::Number.between(from: 2, to: 7) }
    charge_id { Faker::Number.between(from: 2, to: 3) }
    region_id { Faker::Number.between(from: 2, to: 48) }
    number_of_day_id { Faker::Number.between(from: 2, to: 48) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
  end
end
