class User < ApplicationRecord
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :role, presence: true

  validates :user_name, uniqueness: true, presence: true

  enum role: ["default", "admin", "merchant_admin"]

  has_many :orders
  belongs_to :merchant, optional: true

  has_secure_password
end
