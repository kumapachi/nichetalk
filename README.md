# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false, default: ""  |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |


### Association

- has_many :topics
- has_many :comments
- has_many :favorites
- has_many :follows

## topics テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| user              | references | null: false, foreign_key: true |
| title             | string     | null: false                    |
| content           | text       | null: false                    |
| category_id       | integer    | null: false                    |

### Association

- belongs_to  :user
- has_many    :comments
- has_many    :favorites
- has_one_attached :image

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| topic   | references | null: false, foreign_key: true |
| comment | string     | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :topic
- has_one_attached :image

## favorites テーブル

| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| follower_id  | integer | null: false |
| followed_id  | integer | null: false |

### Association

- has_many : follower
- has_many : followed