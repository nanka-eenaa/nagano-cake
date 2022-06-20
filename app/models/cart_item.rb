class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :quantity, presence: true

  def sub_total
    item.tax_price * quantity
  end

end