class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.integer :customer_id, null: false #顧客のid
      t.integer :total_price, null: false #購入金額
      t.string :name, null: false #配送先宛名
      t.string :postcode, null: false #配送先郵便番号
      t.string :addresses, null: false #配送先郵便番号
      t.integer :payment_method, null: false, default: 0 #支払い方法
      t.integer :postage, null: false #送料
      t.integer :status, null: false, default: 0 #受注ステータス

      t.timestamps
    end
  end
end
