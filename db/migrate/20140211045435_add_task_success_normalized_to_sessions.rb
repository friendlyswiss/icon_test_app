class AddTaskSuccessNormalizedToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :task_success_normalized, :float
    remove_column :sessions, :years_exp, :string
  end
end
