class CreateActionRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :action_records do |t|
      t.string :action_image
      t.text :action_comment
      t.references :goal, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
