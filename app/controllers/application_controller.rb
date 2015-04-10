class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :expire_hsts

  private
  def expire_hsts
    response.headers["Strict-Transport-Security"] = 'max-age=0'
  end
  # It will re-login if a user tries to access the application from a different shop
  # before_filter :login_again_if_different_shop
  
  # Ask shop to authorize app again if additional permissions are required
  # rescue_from ActiveResource::ForbiddenAccess do
  #   session[:shopify] = nil
  #   flash[:notice] = "This app requires additional permissions, please log in and authorize it."
  #   redirect_to controller: :sessions, action: :create
  # end
end
