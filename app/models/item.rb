class Item < ApplicationRecord
  has_one_attached :item_image

  has_many :cart_items
  has_many :order_details
  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true
  validates :without_tax, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :is_active, inclusion: { in: [true, false] }
  
  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end

  def add_tax_price
    (self.without_tax * 1.10).round
  end
end
