sudo apt-get update && sudo apt-get install -y default-mysql-client

# wait-for-it.sh のダウンロードと権限付与
curl -o /workspace/.devcontainer/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
chmod +x /workspace/.devcontainer/wait-for-it.sh

# db サービスが起動するまで待機
/workspace/.devcontainer/wait-for-it.sh db:3306 -- echo "DB is up"

echo "first"
mysql -h db -P 3306 -uroot -ptest <<EOF
GRANT ALL PRIVILEGES ON *.* TO 'test'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# 不要なので削除
rm /workspace/.devcontainer/wait-for-it.sh

# setup
cd /workspace/oauth
bundle install -j 4
rails db:create

