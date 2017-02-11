class Friend < ApplicationRecord

  belongs_to :chatter, class_name: 'User', foreign_key: 'chatter_id'
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  
end
