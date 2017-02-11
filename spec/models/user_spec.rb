require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:requests_sent) }
  it { should have_many(:requests_received) }
  it { should have_many(:friends) }
  it { should have_many(:chatters) }
end
