class Item < ApplicationRecord
  belongs_to :user
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
end
