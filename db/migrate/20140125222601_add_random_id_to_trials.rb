class AddRandomIdToTrials < ActiveRecord::Migration
  def change
    add_column :trials, :random_id, :integer
    add_column :sessions, :random_id, :integer
  end
end
