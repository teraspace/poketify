
# poketify
Pokemon browser for Modyo
=======
# README

Features:
  Pokemon listed by 20 per page, with name, type, base experience, weight, height and abilities.
  by click on it; you can get Description and Evolutions.


Tecnical requirements:
* Ruby 3.0.0
* Rails 7.1.3
* Node > 21
* Yarn

Configuration:

1. Clone the repository
2. cd poketify
3. Run yarn install, npm install
4. rake db:create, rake db:migrate
5. bundle exec bootsnap precompile app/ lib/
6. ./bin/rails assets:precompile
7. ./bin/dev
8. Open localhost:3000 in your favorite browser


Stack used:

Ruby on Rails, Reactjs integrated in the erb's

API cached by Rails.cache


Technical debts:

Migrate paginator to ReactJs
