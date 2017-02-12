class Api::V1::RequestsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_requests
    data = JSON.parse(request.body.read)
    @user = User.find_by facebook_id: data["facebook_id"]
    @requests = @user.requests_received
    @requesters = []
    @requests.each do |request|
      @requesters << User.find(request.sender_id)
    end
    render json: { requests: @requesters }
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

end
