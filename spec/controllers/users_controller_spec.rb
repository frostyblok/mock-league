require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user_params) {
    {
      first_name: 'Oluwakunle',
      last_name: 'Fakorede',
      password: 'ideyhear',
      password_confirmation: 'ideyhear',
      email: 'oluwa@example.com'
    }
  }
  let(:json) { JSON.parse(response.body) }

  context "#signup" do
    before { post :signup, params: user_params }

    it "successfully creates a user" do
      expect(json["message"]).to eq("User successfully created")
    end
  end

  context "#login" do
    let(:user) { create(:user) }
    before { post :signin, params: { email: user.email, password: user.password } }
    it "successfully signs in a user" do
      expect(json["message"]).to eq("User successfully signed in")
    end
  end
end
