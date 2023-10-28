## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| family_name        | string  | null: false               |
| first_name         | string  | null: false               |
| family_name_kana   | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_day          | date    | null: false               |

### Association

- has_many :items
- has_many :purchase_records
- has_one :shipping

## items テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| image          | string     | null: false                    |
| name           | string     | null: false                    |
| explanation    | string     | null: false                    |
| category       | integer    | null: false                    |
| condition      | integer    | null: false                    |
| charge         | integer    | null: false                    |
| region         | integer    | null: false                    |
| number_of_days | integer    | null: false                    |
| price          | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record

## purchase_records テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## shippings テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture    | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| telephone     | string     | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user