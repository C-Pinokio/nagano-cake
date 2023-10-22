class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true, uniqueness: true
  
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
