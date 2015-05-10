class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_flash
    if params[:notice].present? then
      flash[:notice] = params[:notice]
    end
  end

end
