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

### Association

- has_many :topics
- has_many :rooms
- has_many :messages
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
- has_one     :room
- has_many    :favorites
- has_many_attached :images

## rooms テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| topic   | references | null: false, foreign_key: true |

### Association

- has_many :users
- has_one  :topic
- has_many :messages

## messages テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| topic   | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |
| comment | string     |                                |

### Association

- belongs_to :user
- belongs_to :topic
- belongs_to :room
- has_one_attached :image

## favorites テーブル

| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| follower_id  | integer | null: false |
| followed_id  | integer | null: false |

### Association

- has_many : follower
- has_many : followed