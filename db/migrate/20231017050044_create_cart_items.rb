class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      
      t.integer :item_id, null: false #商品のID
      t.integer :customer_id, null: false #顧客のID
      t.integer :amount, null: false #個数

      t.timestamps
    end
  end
end
