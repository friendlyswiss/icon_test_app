class RemoveTaskSuccessNormalizedToSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :task_success_normalized, :float
    add_column :sessions, :success_rate_normalized, :float
  end
end
