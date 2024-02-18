# Procfile for development using HMR
# You can run these commands in separate shells
rails: RAILS_ENV=production bundle exec rails s -p 3000
wp-client: bin/shakapacker-dev-server
wp-server: SERVER_BUNDLE_ONLY=yes bin/shakapacker --watch
js: yarn build --watch
css: yarn watch:css
css: yarn build:css --watch
