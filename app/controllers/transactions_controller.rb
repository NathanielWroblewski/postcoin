class TransactionsController < ApplicationController
  before_filter :sanitize_params, only: :create

  def new

  end

  def create
    Transaction.new(
      private_key: current_user.private_key,
      sender_address: current_user.addresses.last.to_s,
      unspents: fetch_unspents(current_user.addresses.last.to_s),
      amount: params[:amount].to_i,
      recipient_address: params[:address]
    )
    redirect_to current_user
  end

  private

  def sanitize_params
    balance = fetch_balance(current_user.addresses.last.to_s)
    if params[:address].blank? || params[:amount].blank? ||
      (10_000 + params[:amount].to_i) > balance
      render :new
    end
  end

  def fetch_unspents(address)
    url = "http://#{ENV['HELLOBLOCK_ENV']}.helloblock.io/addresses/#{address}/unspents"
    response = HTTParty.get(url)
    response['data']['unspents'].map do |unspent|
      [unspent['scriptPubKey']].pack('H*')
    end
  end
end
