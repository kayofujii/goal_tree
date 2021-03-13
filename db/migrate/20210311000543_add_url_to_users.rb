class AddUrlToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :url, :text
  end
end
