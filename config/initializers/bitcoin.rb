if Rails.env.production?
  Bitcoin.network = :bitcoin
else
  Bitcoin.network = :testnet3
end
