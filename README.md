# ラベリット！
![image](https://user-images.githubusercontent.com/68311116/92682514-7cdb0480-f36b-11ea-84cf-b40d20a15ca3.png)

<br>

# 概要  
・付箋を作成し、その付箋をメモとしてまとめることが出来ます。  
※アプリ名「ラベリット!」はLabel(付箋)とITを続けて読むことで成立する造語です。

<br>

# 作成動機
前職で、何か記録を残すとき付箋とメモを併用又は使い分けていました。  
その際、ツールについて以下の特性を感じました。

・付箋の長所 「簡単に使い捨てることが出来る」  
・付箋の短所 「長期の保管が難しい」  
・メモの長所 「詳細を記入することが出来る」  
・メモの短所 「情報を修正・追加すると汚くなる」  

両方の良さを活かすライフハックアプリを作成し
公私問わず、記録をとることの効率性を向上させたい  
その理想に突き動かされて、作成しました。

<br>

# 技術・環境等
・フロントエンド(javascript, jQuery, HTML/CSS, Bootstrap)  
・バックエンド(Ruby on Rails)  
・テスト(RSpec, FactoryBot)  
・データベース(MySQL)  
・開発環境(MacOS, VScode, Git, GitHub)  

<br>

# 機能要件  
・ユーザー管理機能  
・ラベル投稿機能  
・ラベル検索機能  
・ラベル一覧表示機能  
・ラベル削除機能  
・メモ投稿機能  
・メモ一覧表示機能  
・メモ詳細機能  
・メモ編集機能  
・メモ削除機能  
・ラベル・メモリンク機能  
・メモお気に入り機能  

<br>

# テーブル設計

## users テーブル

| Column            | Type              | Options                 |
| ----------------- | ----------------- | ----------------------- |
| name              | string            | null: false             |
| email             | string            | null: false             |
| password          | string            | null: false             |

### Association
- has_many :posts,     dependent: :destroy
- has_many :memos,     dependent: :destroy
- has_many :favorites, dependent: :destroy

## posts テーブル

| Column            | Type              | Options                        |
| ----------------- | ----------------- | ------------------------------ |
| body              | text              | null: false                    |
| user              | references        | null: false, foreign_key: true |

### Association
- has_many :memo_posts, dependent: :destroy
- has_many :memos,      :through => :memo_posts
- belongs_to :user

## memosテーブル

| Column               | Type            | Options                        |
| -------------------  | --------------- | ------------------------------ |
| title                | string          | null: false                    |
| desc                 | text            | null: false                    |
| user                 | references      | null: false, foreign_key: true |

### Association
- has_many   :memo_posts, dependent: :destroy
- has_many   :posts, :through => :memo_posts
- accepts_nested_attributes_for :memo_posts, allow_destroy: true
- has_many   :favorites, dependent: :destroy
- has_many   :favorite_users, :through => :favorites, source: :user
- belongs_to :user

## memo_posts テーブル

| Column               | Type            | Options                        |
| -------------------  | --------------- | ------------------------------ |
| post                 | references      | index: true, foreign_key: true |
| memo                 | references      | index: true, foreign_key: true |

### Association
- belongs_to :post,dependent: :delete
- belongs_to :memo

## favorites テーブル

| Column               | Type            | Options                        |
| -------------------  | --------------- | ------------------------------ |
| user_id              | integer         |                                |
| memo_id              | integer         |                                |

### Association
- belongs_to :user
- belongs_to :memo
