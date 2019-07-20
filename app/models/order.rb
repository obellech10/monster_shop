class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  belongs_to :user

  validates_presence_of :status

  enum status: ["pending", "packaged", "shipped", "cancelled"]

  def grand_total
    order_items.sum('price * quantity')
  end
end
