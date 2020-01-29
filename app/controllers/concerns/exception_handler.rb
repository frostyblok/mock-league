module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class Unauthorized < StandardError; end

  included do
    # custom handler
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ExceptionHandler::AuthenticationError, with: :authenticate_error
    rescue_from ExceptionHandler::MissingToken, with: :unprocessable_entity
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessable_entity
    rescue_from ExceptionHandler::Unauthorized, with: :unauthorized_request

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { error: e.message, status: 404 }
    end
  end

  private

  def unprocessable_entity(error)
    render json: { error: error.message, status: 422 }
  end

  def authenticate_error(error)
    render json: { error: error.message, status: 401 }
  end

  def unauthorized_request(error)
    render json: { error: error.message, status: 403 }
  end
end
