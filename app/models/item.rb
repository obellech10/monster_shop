class Item < ApplicationRecord
  belongs_to :merchant
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy

  validates_presence_of :name,
                        :description,
                        :image,
                        :price,
                        :inventory

  def sorted_reviews(limit = nil, order = :asc)
    reviews.order(rating: order).limit(limit)
  end

  def average_rating
    reviews.average(:rating)
  end

  def self.bottom_five
    OrderItem.joins(:item)
             .order(:quantity)
             .limit(5)
             .pluck("items.name", :quantity)
  end

  def self.top_five
    OrderItem.joins(:item)
             .order(quantity: :desc)
             .limit(5)
             .pluck("items.name", :quantity)
  end

  def item_quantity
    Item.joins(:order_items).where("order_id = #{id}").where("merchant_id = #{merchant.id}").pluck(:quantity).first
  end

  def item_status
    Item.joins(:order_items).where("order_id = #{id}").where("merchant_id = #{merchant.id}").pluck(:fulfilled).first
  end

  def item_status_message
    if self.item_status == false
      "This item has not yet been fulfilled."
    else
      "This item has already been fulfilled."
    end
  end

end
