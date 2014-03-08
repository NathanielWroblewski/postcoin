class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: :new

  def new
    @balance = fetch_balance(current_user.addresses.last.to_s)
  end

  def show
    @user = current_user
  end

  private

  def fetch_balance(address)
    response = HTTParty.get("http://mainnet.helloblock.io/addresses/#{address}")
    response['data']['address']['balance']
  end
end
