class User < ApplicationRecord
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  validates :user_name, uniqueness: true, presence: true

  enum role: ["default", "admin", "merchant"]

  has_many :orders

  has_secure_password
end
