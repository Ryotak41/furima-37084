# テーブル設計

## users テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| nickname           | string     | null: false                    |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |
| name               | string     | null: false                    |
| name_kana          | string     | null: false                    |
| birthday           | date       | null: false                    |

### Association

- has_many :item
- has_many :order

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item               | string     | null: false                    |
| description        | text       | null: false                    |
| category           | string     | null: false                    |
| situation          | string     | null: false                    |
| delivery_charge    | string     | null: false                    |
| area               | string     | null: false                    |
| shipping_days      | string     | null: false                    |
| price              | integer    | null: false                    |
| sales_commission   | integer    | null: false                    |
| sales_profit       | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :order

## orders テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| card               | integer    | null: false                    |
| expiry_month       | integer    | null: false                    |
| expiry_year        | integer    | null: false                    |
| security_code      | integer    | null: false                    |
| post_code          | string     | null: false                    |
| prefectures        | string     | null: false                    |
| municipalities     | string     | null: false                    |
| address            | string     | null: false                    |
| building           | string     |                                |
| telephone          | integer    | null: false                    |
| item               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item