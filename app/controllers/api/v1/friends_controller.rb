class Api::V1::FriendsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_friends
    data = JSON.parse(request.body.read)
    @user = User.find_by id: data["id"]
    @friend_ids = @user.friends
    @friends = []
    @friend_ids.each do |friend|
      @friends << User.find(friend)
    end
    render json: @friends
  end

end
