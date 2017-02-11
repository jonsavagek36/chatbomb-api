class Api::V1::RequestsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_requests
    data = JSON.parse(request.body.read)
    @user = User.find_by id: data["id"]
    @request_ids = @user.received_requests
    @requests = []
    @request_ids.each do |request|
      sender = Request.find(request).req_sender
      @requests << User.find(sender)
    end
    render json: @requests
  end

  def send_request
    data = JSON.parse(request.body.read)
    @receiver = User.find_by fb_email: data["receiver_email"]
    if @receiver.nil?
      render json: { message: "User does not exist." }
    else
      Request.create!(req_sender: data["id"], req_receiver: @receiver.id)
      render json: { message: "Request sent." }
    end
  end

end
