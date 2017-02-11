require 'rails_helper'

RSpec.describe Friend, type: :model do
  it { should belong_to(:chatter) }
  it { should belong_to(:friend) }
end 
