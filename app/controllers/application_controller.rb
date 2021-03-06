class ApplicationController < ActionController::API
  before_filter :check_token
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def check_token
    assigned_token = ENV['TOKEN']
    return unless assigned_token.present?
    return if params[:token] == assigned_token
    return if request.headers['Authorization'] == "token #{assigned_token}"
    return if authenticate_with_http_basic {|u, p| u == assigned_token}
    head :forbidden
  end
end
