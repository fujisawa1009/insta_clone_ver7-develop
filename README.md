初回のみ

$ git init

$ git add .

$ git commit "initial commit"

$ git remote add origin 上記手順で作成したGitHubリポジトリのURL

$ git push origin main

初回のみDB作成 $ docker-compose up

$ docker-compose exec web bash

$ bin/rails db:create

# 起動メモ
docker-compose run --rm web bundle

docker-compose build

docker compose up

# rspecメモ
rspec --initを実行すると自動的に以下ファイルが生成
.rspec
spec/rails_helper.rb
spec/spec_helper.rb
実行時は
docker compose exec web bashしてから

rspec

# rubocopメモ
rubocop -a

# erb-lint ERBチェック
bundle exec erblint . -a

#改修メモ
Gem を追加したので bundle install を実行してください

カラムを追加したので bin/rails db:migrate を実行してください

コマンドでの実行
gemインストール

docker-compose  run --rm web bundle

■コントローラ作成
docker compose exec web bash

bin/rails g controller users index

■モデル作成手順
docker compose exec web bash

bin/rails g model post

マイグレーションファイルを書き換える
bin/rails db:migrate

もしくは
docker-compose run web bundle exec rake db:migrate

■scaffoldingで一括作成時
bin/rails g scaffold question name:string title:string content:text 

bin/rails db:migrate


