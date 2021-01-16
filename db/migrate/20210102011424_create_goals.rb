class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|

      t.text :goal_content, null: false
      t.text :action_content, null: false
      t.text :identity_content, null: false
      t.integer :rank, null: false, default: 0

      t.timestamps
    end
  end
end
