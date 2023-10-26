class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.integer :item_id, null: false #商品のID
      t.integer :order_id, null: false #注文のID
      t.integer :amount, null: false #注文個数
      t.integer :include_tax, null: false #購入時税込価格
      t.integer :making_status, null: false, default: 0 #制作ステータス
      
      t.timestamps
    end
  end
end
