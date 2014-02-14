class RemoveSessionIdFromTrials < ActiveRecord::Migration
  def change
    remove_column :trials, :session_id, :string
  end
end
