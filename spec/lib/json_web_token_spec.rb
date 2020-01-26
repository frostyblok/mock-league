require "rails_helper"

RSpec.describe JsonWebToken do
  let(:user) { create(:user) }
  let(:user_token) { described_class.encode({user_id: user.id}) }
  let(:decoded_user_token) { described_class.decode(user_token) }

  it "returns user token" do
    expect(user_token).not_to be_nil
  end

  it "decodes token and return user" do
    expect(decoded_user_token[:user_id]).to eq(user.id)
  end
end
