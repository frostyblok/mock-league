require 'rails_helper'

RSpec.describe Fixture, type: :model do
  it { should validate_presence_of(:home_team_id) }
  it { should validate_presence_of(:away_team_id) }
  it { should validate_presence_of(:date) }
  it { should belong_to(:home_team) }
  it { should belong_to(:away_team) }
end
