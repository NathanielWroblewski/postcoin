class PagesController < ApplicationController
  skip_before_filter :authenticate_user!, only: :amounts

  def amounts
  end
end
