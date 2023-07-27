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
