class Address < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true

  def to_s
    address
  end
end
