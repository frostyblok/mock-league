# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user, password: 'password') }
  let(:password) { user.password }
  let(:token) { described_class.new(email: user.email, password: password).call }

  context '#call' do
    it 'returns a token' do
      expect(token).not_to be_nil
    end

    context 'when invalid password' do
      let(:password) { 'Invalid_password' }
      it 'returns nil' do
        expect { token }
          .to raise_error(
                ExceptionHandler::AuthenticationError,
                /Invalid credentials/
              )
      end
    end
  end
end
