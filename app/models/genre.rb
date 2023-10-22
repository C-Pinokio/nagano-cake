class Genre < ApplicationRecord
  has_many :items, dependent: :destroy
  validates :name, presence: { message: "ジャンル名を入力してください" }
end
