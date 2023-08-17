FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile

ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
# Выполняем миграции базы данных2
RUN rake db:reset RAILS_ENV=development
RUN rails db:migrate RAILS_ENV=development
# Запускаем сервер приложения на порту 3000
#CMD ["rails", "server", "-b", "0.0.0.0"]
