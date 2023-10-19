class Address < ApplicationRecord
  belongs_to :customer
  
  validates :postcode, presence: true
  validates :address, presence: true
  validates :name, presence: true
  # validates :customer_id, presence: true
  
  
  def address_display
    '〒' + postcode + ' ' + address + ' ' + name + ' 様 '
  end
end
