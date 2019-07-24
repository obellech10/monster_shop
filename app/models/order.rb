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

  def total_merchant_items(merchant)
    Item.joins(:order_items).where("order_id = #{id}").where("merchant_id = #{merchant.id}").sum(:quantity)
  end

  def total_value(merchant)
    red = Item.joins(:order_items).where("order_id = #{id}").where("merchant_id = #{merchant.id}").pluck(:price).flatten
    blue = Item.joins(:order_items).where("order_id = #{id}").where("merchant_id = #{merchant.id}").pluck(:quantity).flatten
    red.first * blue.first
  end

  def user_address(order)
    red = Order.where("id = #{order.id}").select(:user_id)
    blue= User.where(id: red).pluck(:address, :city, :state, :zip).flatten
    "#{blue[0]} #{blue[1]} #{blue[2]} #{blue[3]}"
  end

  def merchant_items(merchant)
    Item.joins(:order_items).where("order_id = #{id}").where("merchant_id = #{merchant.id}")
  end

  def all_fulfilled?
    self.order_items.all? { |order_item| order_item.fulfilled == true }
  end
  
  def self.sorted_orders
    self.order(:status)
  end
end
