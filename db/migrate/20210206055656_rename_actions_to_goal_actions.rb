class RenameActionsToGoalActions < ActiveRecord::Migration[6.1]
  def change
    rename_table :actions, :goal_actions
  end
end
