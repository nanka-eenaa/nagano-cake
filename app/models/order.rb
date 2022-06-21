class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { customer_payment: 0, payment_confirmed: 1, production: 2, preparation: 3, shipped: 4 }

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :post_code, presence: true
  validates :address, presence: true
  validates :postage, presence: true
  validates :name, presence: true
  validates :total_payment, presence: true

end
