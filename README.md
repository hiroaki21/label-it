# ラベリット！
![Image from Gyazo](https://i.gyazo.com/fe01e61164b4ef9d99abc0b715e4011f.jpg)


<br>

# 概要  
付箋を作成し、その付箋をメモとしてまとめることが出来ます。  
※アプリ名「ラベリット!」はLabel(付箋)とITを続けて読むことで成立する造語です。

アプリURL : https://label-it-memo.com  

【推奨環境】  
ブラウザ：Google Chrome  
※レスポンシブ非対応のためノートPCの利用を推奨しています。

<br>

# 作成動機
前職で、情報等を記録に残すとき「付箋」と「メモ」を併用していました。  
それは、それぞれに以下の特徴があると感じていたからです。

・付箋の長所 「手軽さ・使い捨てが容易であること」  
・付箋の短所 「長期の保管が困難であること」  
・メモの長所 「詳細な記入が可能であること」  
・メモの短所 「情報を修正・追加すると紙面が汚れること」  

上記の特徴を踏まえ、初見の情報は、即効性のある付箋で記録し  
事後、タイミングを見計らい、その情報の詳細をメモ帳等に記録していました。  
結果、以下のメリットが得られました。  

・メモ帳等に綺麗に記録できるので、見直したときに内容の理解が容易  
・付箋からメモへ情報を選別することで、記憶の整理・定着が促進  

もちろん、デメリットもありました。  

・付箋→メモの作業が手間  
・記載した内容の検索に時間を要する  

上記のデメリットを解消するために、思いついたのが、「付箋→メモ」をIT化する  
すなわち、付箋とメモ、それぞれをIT化させることに加え、  
その接続部分も「付箋→IT→メモ」のように進化させることでした。  

「前職で感じた不便さを解消し、今後も踏まえ、記録をとることの効率性を追求する」  
この強い想いが、本アプリ開発へと私を突き動かしました。  

<br>

# 機能要件  
・ユーザー管理機能  
・ラベル投稿機能  
・ラベル検索機能  
・ラベル一覧表示機能  
・ラベル削除機能  
・メモ投稿機能(ラベル添付可能)  
・メモ一覧表示機能  
・メモ詳細表示機能  
・メモ編集機能  
・メモ削除機能  
・ラベル/メモリンク機能  
・メモお気に入り機能  

※ラベルとは付箋のことを指します。

<br>

# 使用例（gif添付）
### ---業務中---  

在宅勤務中の課長から入電  
課長「来月の監査の打ち合わせ！明日の15時からやろう！中会議室とお茶用意しておいて！あといつもの資料も」  
私「承知しました」

機能：ラベル投稿機能

![label-it1](https://user-images.githubusercontent.com/68311116/94100309-4bccfa80-fe68-11ea-977c-cbce41d5cc60.gif)

### ---休憩中---  

仕事が一区切りついたので、先ほどのラベルをメモにまとめる  

機能：メモ投稿機能(ラベル添付)・メモ詳細表示機能  

![label-it2](https://user-images.githubusercontent.com/68311116/94100473-bc741700-fe68-11ea-9cc9-d6aa843b4afb.gif)

### ---10分後---  

部署内で課長とのやりとりを共有  
先輩「お茶は綾鷹じゃなくて伊右衛門に、人数は5人にしておいて」  
私「承知しました」  

機能：ラベル一覧表示機能・ラベル削除機能・ラベル/メモリンク機能・メモ編集機能・メモお気に入り機能・メモ一覧表示機能  

![label-it3](https://user-images.githubusercontent.com/68311116/94100738-49b76b80-fe69-11ea-8841-3239367bb83e.gif)

<br>

# 技術・環境等
・フロントエンド(Javascript, jQuery, HTML/CSS,SCSS, Bootstrap)  
・バックエンド(Ruby on Rails)  
・テスト(RSpec, FactoryBot, Rubocop)  
・データベース(MariaDB)  
・インフラ(AWS(EC2、Route53、ALB), Nginx, Unicorn)  
・開発ツール(VSCode, Git, GitHub, Capistrano)  

![cloud](https://user-images.githubusercontent.com/68311116/116982011-40e21e80-ad03-11eb-934b-4e8bfe632375.png)



<br>

# テーブル設計
※postはlabel(付箋)と同義
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
- has_many   :favorites, dependent: :destroy
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

![er](https://user-images.githubusercontent.com/68311116/94236598-79897080-ff48-11ea-9bee-d68bcb07775f.png)
