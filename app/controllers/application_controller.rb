class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  private

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || current_user || root_path
  end

  def fetch_balance(address)
    response = HTTParty.get("http://#{ENV['HELLOBLOCK_ENV']}.helloblock.io/addresses/#{address}")
    response['data']['address']['balance']
  end
end
