class AddUserIdToGoals < ActiveRecord::Migration[6.1]
  def up
    execute 'DELETE FROM goals;'
    add_reference :goals, :user, index: true
  end
end
