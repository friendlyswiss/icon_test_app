class RemoveTaskStartEndFromTrials < ActiveRecord::Migration
  def change
    remove_column :trials, :task_start, :string
    remove_column :trials, :task_end, :string
  end
end
