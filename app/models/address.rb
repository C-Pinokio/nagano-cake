class Address < ApplicationRecord
  belongs_to :customer
  
  
  
  def address_display
    '〒' + postcode + ' ' + address + ' ' + name + ' 様 '
  end
end
