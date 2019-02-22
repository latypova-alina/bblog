class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include BulletHelper

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def record_not_found
    redirect_to root_path, alert: "Page or record not found!"
  end
end
