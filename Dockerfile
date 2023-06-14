FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile

ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
# Выполняем миграции базы данных
RUN rails db:migrate
# Запускаем сервер приложения на порту 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
