class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  
  def  add_tax_price #単価(税込)
    (self.without_tax * 1.1)
  end
end
