class OrderDetail < ApplicationRecord
  enum status: { pending: 0, ready: 1, working: 2, completed: 3 }

  belongs_to :order
  belongs_to :item
end
