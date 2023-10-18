class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      
      t.integer :customer_id, null: false #顧客のID
      t.string :postcode, null: false #郵便番号
      t.string :address, null: false #住所
      t.string :name, null: false #宛名

      t.timestamps
    end
  end
end
