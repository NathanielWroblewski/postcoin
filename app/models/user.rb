class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :addresses
  has_many :sent_emails, class_name: 'Email', foreign_key: :sender_id
  has_many :received_emails, class_name: 'Email', foreign_key: :recipient_id

  before_validation :generate_keys, on: :create
  after_create :generate_address
  after_create :generate_password, unless: :encrypted_password?
  after_create :send_email_notification

  validates :private_key, presence: true
  validates :public_key,  presence: true

  def generate_keys
    self.private_key, self.public_key = Bitcoin.generate_key
  end

  def generate_address
    addresses.create(address: Bitcoin.pubkey_to_address(public_key))
  end

  def generate_password
    generated_password = Devise.friendly_token.first(8)
    update_attributes(password: generated_password)
    RegistrationMailer.welcome(id, generated_password).deliver
  end

  def send_email_notification

  end
end
