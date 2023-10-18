class AddColumnsToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :genre_id, :integer, null: false
    add_column :items, :name, :string, null: false
    add_column :items, :introduction, :text, null: false
    add_column :items, :without_tax, :integer, null: false
    add_column :items, :is_active, :boolean, null: false, default: true
  end
end
