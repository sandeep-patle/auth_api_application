class UserDetail < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :mobile_number, :user_id

  validates :first_name, presence: true, length: { maximum: 50 }

  validates :last_name, presence: true, length: { maximum: 50 }

  validates :mobile_number, presence: true, length: { maximum: 11 }

  belongs_to :user
end
