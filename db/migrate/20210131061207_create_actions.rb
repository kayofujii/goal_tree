class CreateActions < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.string :action_name
      t.references :goal, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
