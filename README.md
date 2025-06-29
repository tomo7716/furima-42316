# README



#テーブル設計

##usersテーブル

| Column              | Type        | Options                             |
| --------------------| ------------| ------------------------------------|
| nickname            | string      | null: false                         |
| email               | string      | null: false, unique:  true          |
| encrypted_password  | string      | null: false                         |
| last_name           | string      | null: false                         |
| first_name          | string      | null: false                         |
| last_name_kana      | string      | null: false                         |
| first_name_kana     | string      | null: false                         |
| birth_date          | date        | null: false                         |
| created_at          | datetime    | null: false                         |
| updated_at          | datetime    | null: false                         |


##items テーブル
| Column              | Type        | Options                             |
| --------------------| ------------| ------------------------------------|
| name                | string      | null: false                         |
| description         | text        | null: false                         |
| category_id         | integer     | null: false                         |
| condition_id        | integer     | null: false                         |
| shipping_fee_id     | integer     | null: false                         |
| prefecture_id       | integer     | null: false                         |
| shipping_days_id    | integer     | null: false                         |
| price               | integer     | null: false                         |
| user_id             | references  | null: false,  foreign_key:  true    |
| created_at          | datetime    | null: false                         |
| updated_at          | datetime    | null: false                         |


##orders テーブル
| Column              | Type        | Options                             |
| --------------------| ------------| ------------------------------------|
| user_id             | references  | null: false,  foreign_key:  true    |
| item_id             | references  | null: false,  foreign_key:  true    |
| created_at          | datetime    | null: false                         |
| updated_at          | datetime    | null: false                         |

##addresses テーブル
| Column              | Type        | Options                             |
| --------------------| ------------| ------------------------------------|
| postal_code         | string      | null: false                         |
| prefecture_id       | integer     | null: false                         |
| city                | string      | null: false                         |
| house_number        | string      | null: false                         |
| building_name       | string      |                                     |
| phone_number        | string      | null: false                         |
| order_id            | references  | null: false,  foreign_key:  true    |


### Association
##usersテーブル
- has_many:items
- has_many:orders

##items テーブル
- has_one:order
- belongs_to :user

##orders テーブル
- belongs_to :user
- belongs_to :item
- has_one:address

##addresses テーブル
- belongs_to :order