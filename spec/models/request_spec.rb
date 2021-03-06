require 'rails_helper'

RSpec.describe Request, type: :model do
  it { should belong_to(:req_sender) }
  it { should belong_to(:req_receiver) }
end
