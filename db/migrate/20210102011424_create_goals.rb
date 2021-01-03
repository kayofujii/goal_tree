class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|

      t.text :goal_content
      t.text :action_content
      t.text :identity_content
      t.integer :rank

      t.timestamps
    end
  end
end
