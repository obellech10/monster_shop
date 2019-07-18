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

  def bottom_five_quantity
    b_five_quant = OrderItem.all.order(:quantity).select(:quantity).limit(5).pluck(:quantity).flatten
    bottom_five = OrderItem.all.order(:quantity).select(:item_id).limit(5).pluck(:item_id)
    b_five_names = Item.select(:name).where(id: bottom_five)
    Hash[b_five_names.zip(b_five_quant.map {|i| i.include?(',') ? (i.split /, /) : i})]
  end

  def top_five_quanitiy
    t_five_quant = OrderItem.all.order(:quantity).reverse_order.select(:quantity).limit(5).pluck(:quantity).flatten
    top_five = OrderItem.all.order(:quantity).reverse.order.select(:item_id).limit(5).pluck(:item_id)
    t_five_names = Item.select(:name).where(id: top_five)
    Hash[t_five_names.zip(t_five_quant.map {|i| i.include?(',') ? (i.split /, /) : i})]
  end

end
