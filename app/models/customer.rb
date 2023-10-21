class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :last_name, presence: true#氏名が空白はだめ
  validates :first_name, presence: true#名前が空白はだめ
  validates :last_name_kana, presence: true#フリガナが空白はだめ
  validates :first_name_kana, presence: true#フリガナが空白はだめ
  validates :postcode, presence: true#郵便番号が空白はだめ
  validates :address, presence: true#住所が空白はだめ
  validates :phone_number, presence: true#電話番号が空白はだめ
  
  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  
   def full_name
    "#{last_name} #{first_name}"
   end
   
   def full_name_kana
     "#{last_name_kana} #{first_name_kana}"
   end
  
  def active_for_authentication?
    # is_deletedがfalseならtrueを返すようにしている
    super && (is_deleted == false)
  end
  
end
