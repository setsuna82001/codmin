class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login unless Rails::env.test?

  private
  def not_authenticated
    redirect_to login_path, flash: {warning: 'ログインが必要です！'}
  end
end
