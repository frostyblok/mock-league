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

  before do
    post :signup, params: user_params
  end

  it "successfully creates a user" do
    expect(json["message"]).to eq("User successfully created")
  end
end
