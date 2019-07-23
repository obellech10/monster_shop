class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  belongs_to :user

  validates_presence_of :status

  enum status: ["pending", "packaged", "shipped", "cancelled"]

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

end
