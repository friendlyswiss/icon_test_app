class AddSessionIdToTrials < ActiveRecord::Migration
  def change
    add_column :trials, :session_id, :integer
  end
end
