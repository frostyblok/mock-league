# frozen_string_literal: true

class AuthorizeRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    { user: user, role: user.role }
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decode_token[:user_id])
  rescue ActiveRecord::RecordNotFound => e
    raise ExceptionHandler::InvalidToken, "Invalid token, #{e.message}"
  end

  def decode_token
    @decode_token ||= JsonWebToken.decode(generate_token_from_headers)
  end

  def generate_token_from_headers
    return headers['Authorization'] if headers['Authorization'].present?

    raise ExceptionHandler::MissingToken, 'Missing token'
  end
end
