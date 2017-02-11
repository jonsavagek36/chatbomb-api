Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "users/sign_in"
      put "users/set_email"
      put "users/set_name"

      post "requests/get_requests"
      post "requests/send_request"

      post "friends/get_friends"
    end
  end
end
