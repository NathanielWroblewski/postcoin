class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :addresses

  before_validation :generate_keys, on: :create
  after_create :generate_address

  validates :private_key, presence: true
  validates :public_key,  presence: true

  def generate_keys
    self.private_key, self.public_key = Bitcoin.generate_key
  end

  def generate_address
    addresses.create(address: Bitcoin.pubkey_to_address(public_key))
  end
end
