class AddRecordUrlToActionRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :action_records, :action_url, :text
  end
end
