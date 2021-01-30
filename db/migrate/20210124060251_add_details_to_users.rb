class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def up
    execute 'DELETE FROM users;'
    add_column :users, :name, :string, null: false
    add_column :users, :description, :text
    add_column :users, :icon, :text
    add_reference :users, :goal, index: true
  end
end
