class Api::V1::RequestsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_requests
    data = JSON.parse(request.body.read)
    @user = User.find_by facebook_id: data["facebook_id"]
    @requests = @user.requests_received
    @requesters = []
    @request_ids = []
    @requests.each do |request|
      @request_ids << request.id
      @requesters << User.find(request.sender_id)
    end
    render json: { requests: { requesters: @requesters, request_ids: @request_ids } }
  end

  def send_request
    data = JSON.parse(request.body.read)
    @sender = User.find_by facebook_id: data["facebook_id"]
    @receiver = User.find_by email: data["request_email"]
    if @receiver.nil?
      render json: { success: false, message: 'User not found.' }
    else
      @request = Request.create!(sender_id: @sender.id, receiver_id: @receiver.id)
      if @request.save!
        render json: { success: true, message: 'Request sent.' }
      else
        render json: { success: false, message: 'Error.' }
      end
    end
  end

  def accept_request
    data = JSON.parse(request.body.read)
    @request = Request.find(data["id"])
    @friend_one = @request.sender_id
    @friend_two = @request.receiver_id
    @one = Friend.create!(user_id: @friend_one, friend_id: @friend_two)
    @two = Friend.create!(user_id: @friend_two, friend_id: @friend_one)
    if @one.save! && @two.save!
      render json: { message: 'Friend added.' }
    else
      render json: { message: 'Acceptance failed.' }
    end
  end

end
