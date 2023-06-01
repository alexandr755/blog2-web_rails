
Rails.application.routes.draw do
  root "articles#index"
  get "/articles", to: "articles#index"

  # О подробностях DSL, доступного в этом файле, написано в http://rusrails.ru/routing
end
