class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = I18n.t("access_denied")
    redirect_to root_path
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options options = {}
    {locale: I18n.locale}.merge options
  end
end
