Rails.application.routes.draw do
  root "home#index"
  apipie
  namespace :api do
    namespace :v1 do
      get "current_date_zodiac_sign", to: "zodiacs#current_date_zodiac_sign", as: "current_sign"
      get "zodiac_sign_by_date", to: "zodiacs#zodiac_sign_by_date", as: "sign_by_date"
      get "date_range_by_sign", to: "zodiacs#date_range_by_sign", as: "date_by_sign"
    end
  end
end
