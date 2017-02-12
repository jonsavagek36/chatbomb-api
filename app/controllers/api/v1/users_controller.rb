class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new_user
    data = JSON.parse(request.body.read)
    @user = User.find_by facebook_id: data["facebook_id"]
    if @user.nil?
      render json: { new_user: true }
    else
      render json: { new_user: false }
    end
  end

  def register
    data = JSON.parse(request.body.read)
    @user = User.create!(facebook_id: data["facebook_id"], facebook_pic: data["facebook_pic"], screen_name: data["screen_name"], email: data["email"])
    if @user.save!
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
 
  def sign_in
    data = JSON.parse(request.body.read)
    @user = User.find_by facebook_id: data["facebook_id"]

    if @user.nil?
      render json: { success: false }
    else
      @requests = @user.requests_received
      @requesters = []
      @requests.each do |request|
        @requests << User.find(request.sender_id)
      end
      @friendships = @user.friends
      @friends = []
      @friendships.each do |friendship|
        @friends << User.find(friendship.friend_id)
      end
      render json: { success: true, user: @user, requests: @requests, friends: @friends }
    end
  end

end
