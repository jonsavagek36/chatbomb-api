Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "users/new_user"
      post "users/register"
      post "users/sign_in"

      post "requests/get_requests"
      post "requests/send_request"

      post "friends/get_friends"
    end
  end
end
