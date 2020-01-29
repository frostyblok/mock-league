# frozen_string_literal: true

module SpecUtilities
  def generate_token(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  def generate_expired_token(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 50))
  end
end
