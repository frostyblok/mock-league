# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  context 'validates presence of role' do
    let(:user) { create(:user, role: 'guest') }

    it 'raises a record invalid error' do
      expect { user }
        .to raise_error(
              ActiveRecord::RecordInvalid,
              /Validation failed: Role is not included in the list/
            )
    end
  end

end
