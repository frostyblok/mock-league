# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request!

  include ExceptionHandler
  include ControllerHelper

  protected

  def authorize_request!
    @current_user = AuthorizeRequest.new(request.headers).call[:user]
  end

  def authorize_admin
    return unless @current_user.role != 'admin'

    raise Unauthorized, 'You are not authorized to perform action'
  end
end
