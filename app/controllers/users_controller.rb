class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: :new

  def new

  end

  def show
    @user = current_user
    @balance = fetch_balance(current_user.addresses.last.to_s)
  end

end
