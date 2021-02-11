class RemoveActionContentFromGoals < ActiveRecord::Migration[6.1]
  def change
    remove_column :goals, :action_content, :text
  end
end
