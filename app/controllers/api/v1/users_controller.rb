class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sign_in
    data = JSON.parse(request.body.read)
    @user = User.find_by fb_id: data["fb_id"]
    if @user.nil?
      @user = User.create!(fb_id: data["fb_id"], fb_photo: data["fb_photo"])
      render json: { user: @user, new_user: true }
    else
      render json: { user: @user, new_user: false}
    end
  end

  def set_email
    data = JSON.parse(request.body.read)
    @user = User.find_by id: data["id"]
    @user.fb_email = data["fb_email"]
    @user.save
    render json: { fb_email: @user.fb_email }
  end

  def set_name
    data = JSON.parse(request.body.read)
    @user = User.find_by id: data["id"]
    @user.screen_name = data["screen_name"]
    @user.save
    render json: { screen_name: @user.screen_name }
  end

end
