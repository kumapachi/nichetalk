# アプリケーション名
NICHE TALK  

# アプリケーション概要
映えない、バズらない、チルいをテーマに、ニッチな話題で盛り上がれる少数派のためのコミュニケーションアプリ  

# URL
https://nichetalk-38528.onrender.com  

# テスト用アカウント
・Basic認証用ID： admin  
・Basic認証用パスワード： 2222  
・メールアドレス: test@test.com  
・パスワード: 111aaa  

# 利用方法

## トピック投稿機能
  1.トップページのヘッダーからユーザー登録を行う  
  2.右下の投稿するボタンをクリックし、トピック投稿画面へ推移する  
  3.画像、タイトル、トピック詳細を入力し投稿するボタンをクリックする  

## チャットルーム機能
  1.トピック詳細画面右下よりチャットルームへ移動するボタンをクリックし、ルームへ推移する  
  2.ルームサイドバーよりチャットを作成するをクリックし、チャットルームを作成する  
  3.サイドバーのチャットルーム名をクリックしチャットルームへ入室する  
  4.下部にメッセージや画像を入力し送信をクリックする  

# アプリケーションを作成した背景
  以前使用していたSNSで常に映えることを意識した投稿を続けることにSNS疲れを感じていた。ただ、映えを意識しない本当に自分を好きなことで共有できる仲間と繋がりたいという思いはあった。
  特に自分と同じ30代男性は同じような悩みを抱えているだろうと推測し、悩みを解決するために、少数派のための映えやバズリを意識しないコミュニケーションが取れるアプリケーションを開発することにした。  

# 洗い出した要件
  要件を定義したシート  
  https://docs.google.com/spreadsheets/d/1ex6EKv3tdV95T-kmqmrW5hseenZFXoOL8O7szyy32rI/edit?usp=sharing  

# 実装した機能についての説明

## ログイン機能

![ログイン動画] (https://drive.google.com/uc?export=view&id=1rUR3bvY8e6dZc2Jr2g5cAPP2Z-GX_HBw)  

https://drive.google.com/file/d/1rUR3bvY8e6dZc2Jr2g5cAPP2Z-GX_HBw/view?usp=share_link  

## トピック投稿機能


![トピック投稿動画] (https://drive.google.com/uc?export=view&id=13RPOhOSP5JnpJ3QAp1E5pd-BA-QAZ6Yy)  

https://drive.google.com/file/d/13RPOhOSP5JnpJ3QAp1E5pd-BA-QAZ6Yy/view?usp=share_link  

# 実装予定の機能
現在、トークルーム機能や実装済み機能の不具合などを修正中  
今後はお気に入り機能やフォロー機能を実装予定  



# データベース設計、画面遷移図

![ER図](https://drive.google.com/uc?export=view&id=1ETu-rrWQ-UQpVGB2QSonfRYyoNUTxBn6)  


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
- has_many    :relationship
- has_many_attached :images

## rooms テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| name    | string     | null: false                    |
| topic   | references | null: false, foreign_key: true |

### Association

- belongs_to  :topic
- has_many    :users
- has_many    :messages
- has_many    :room_users

## room_users テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

## messages テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| topic   | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |
| comment | string     | null: false                    |

### Association

- belongs_to :user
- belongs_to :topic
- belongs_to :room
- has_one_attached :image

## relationships テーブル

| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| follower_id  | integer | null: false |
| followed_id  | integer | null: false |

### Association

- has_many : follower
- has_many : followed

# 開発環境

Ruby/Ruby on Rails/MySQL/GitHub /AWS/Render/Visual Studio Code

# 動作確認方法

・WebブラウザGoogle Chromeの最新版を利用してアクセスしてください。  
・ただしデプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続してください。  
・接続先およびログイン情報については、上記の通りです。  
・同時に複数の方がログインしている場合に、ログインできない可能性があります。  
・テストアカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品  
・確認後、ログアウト処理をお願いします。
