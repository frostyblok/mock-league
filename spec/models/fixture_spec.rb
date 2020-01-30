# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fixture, type: :model do
  it { should validate_presence_of(:home_team_id) }
  it { should validate_presence_of(:away_team_id) }
  it { should validate_presence_of(:date) }
  it { should belong_to(:home_team) }
  it { should belong_to(:away_team) }

  context 'validates presence of completed' do
    let(:fixture) { create(:fixture, completed: 'no') }

    it 'raises a record invalid error' do
      expect { fixture }
        .to raise_error(
              ActiveRecord::RecordInvalid,
              /Validation failed: Completed is not included in the list/
            )
    end
  end
end
