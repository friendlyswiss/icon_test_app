class ChangeDateFormatForTaskTime < ActiveRecord::Migration
  def self.up
  	remove_column :trials, :task_time, :datetime
  	add_column :trials, :task_time, :integer
  end
end
