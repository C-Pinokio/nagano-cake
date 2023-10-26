class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait: 0, check: 1, making: 2, prepare: 3, complete: 4 }
end
