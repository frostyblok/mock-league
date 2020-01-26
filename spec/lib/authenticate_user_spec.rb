require "rails_helper"

RSpec.describe AuthenticateUser do
  let(:user) { create(:user, password: 'password') }

  context "#call" do
    it "returns a token" do
      puts user.inspect
      token = described_class.new(email: user.email, password: user.password).call

      expect(token).not_to be_nil
    end
  end
end