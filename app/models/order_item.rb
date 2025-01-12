class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates_presence_of :price,
                        :quantity

  def subtotal
    quantity * price
  end

  def cancel
    if self.fulfilled?
      self.update(fulfilled: false)
      self.item.update(inventory: (item.inventory + self.quantity))
    end
  end
end
