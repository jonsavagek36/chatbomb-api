class Request < ApplicationRecord

  belongs_to :req_sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :req_receiver, class_name: 'User', foreign_key: 'receiver_id'

end
 
