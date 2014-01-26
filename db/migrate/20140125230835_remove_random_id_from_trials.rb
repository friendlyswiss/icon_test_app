class RemoveRandomIdFromTrials < ActiveRecord::Migration
  def change
    remove_column :trials, :random_id, :integer
    remove_column :sessions, :random_id, :integer
    add_column :trials, :random_id, :string
    add_column :sessions, :random_id, :string
  end
end
