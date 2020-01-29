# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request!

  include ExceptionHandler

  def authorize_request!
    @current_user = AuthorizeRequest.new(request.headers).call[:user]
  end
end
