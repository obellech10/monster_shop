class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  belongs_to :user

  validates_presence_of :status

  enum status: ["packaged", "pending", "shipped", "cancelled"]

  def grand_total
    order_items.sum('price * quantity')
  end

  def total_quantity
    order_items.sum(:quantity)
  end

  def self.sorted_orders
    Order.order(:status)
  end
end
