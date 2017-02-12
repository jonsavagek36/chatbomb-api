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

end
