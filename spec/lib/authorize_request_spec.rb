# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeRequest do
  let(:user) { create(:user) }
  let(:headers) do
    {
      'Authorization' => generate_token(user.id),
      'Content-Type' => 'application/json'
    }
  end
  let(:subject) { described_class.new(headers) }

  context '#call' do
    context 'when token is valid' do
      it 'returns the user' do
        expect(subject.call[:user]).to eq(user)
        expect(subject.call[:role]).to eq(user.role)
      end
    end

    context 'when token has expired' do
      let(:headers) do
        {
          'Authorization' => generate_expired_token(user.id),
          'Content-Type' => 'application/json'
        }
      end

      it 'raises an error' do
        expect { subject.call }
          .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
      end
    end

    context 'when no token provided' do
      let(:headers) do
        {
          'Authorization' => '',
          'Content-Type' => 'application/json'
        }
      end

      it 'raises no token error' do
        expect { subject.call }
          .to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end

    context 'when token is invalid' do
      let(:headers) do
        {
          'Authorization' => 'invalid token',
          'Content-Type' => 'application/json'
        }
      end

      it 'raises invalid token error' do
        expect { subject.call }
          .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
      end
    end
  end
end
