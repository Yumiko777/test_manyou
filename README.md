# README

## システムの要件

- 自分のタスクを簡単に登録したい
- タスクに終了期限を設定できるようにしたい
- タスクに優先順位をつけたい
- ステータス（未着手・着手・完了）を管理したい
- ステータスでタスクを絞り込みたい
- タスク名・タスクの説明文でタスクを検索したい
- タスクを一覧したい。一覧画面で（優先順位、終了期限などを元にして）ソートしたい
- タスクにラベルなどをつけて分類したい
- ユーザ登録し、自分が登録したタスクだけを見られるようにしたい

## DB

### Userテーブル

- name:string
- email_address  :string
- password_digest:string

### Taskテーブル

- title:string
- content:text
- status:integer
- deadline:date
- priority:integer
- user_id:integer

### Lavelテーブル

- user_id:integer
- task_id:integer
- name:string

## Heokuへデプロイ手順

- Gemバージョン：3.0.3

- $ heroku login #ログイン
- $ heroku create #新しいリポジトリ作成
- $ rails assets:precompile RAILS_ENV=production #アセットプリコンパイルを実施
- $ git add .
- $ git commit -m"コミットメッセージ "
- $ git push heroku master #herokuにpush
- $ heroku run rails db:migrate #heroku上にDB作成
- $ heroku config #アプリ名
- Herokuアプリのアドレスはhttps://アプリ名.herokuapp.com/のように設定される
