require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:home_fixtures) }
  it { should have_many(:away_fixtures) }
end
