class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false #商品名
      t.text :introduction, null: false #商品説明
      t.integer :without_tax, null: false  #税抜き価格
      t.integer :genres_id, null: false #ジャンルID
      t.boolean :is_active, default: true, null: false #販売ステータス（trueは販売中、falseは売り切れを表す。）
      t.timestamps
    end
  end
end
