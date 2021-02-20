class AddGoalCategoryIdToGoals < ActiveRecord::Migration[6.1]
  def up
    execute 'DELETE FROM action_records;'
    execute 'DELETE FROM goal_actions;'
    execute 'DELETE FROM goals;'
    add_reference :goals, :goal_category, index: true
  end
end
