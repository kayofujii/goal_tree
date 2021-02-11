class AddGoalActionIdToActionRecords < ActiveRecord::Migration[6.1]
  def change
    add_reference :action_records, :goal_action, foreign_key: true
  end
end
