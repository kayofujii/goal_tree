class CreateSnsCredentials < ActiveRecord::Migration[6.1]
  def change
    create_table :sns_credentials do |t|
      t.string :provider
      t.string :uid
      t.string :nickname
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
