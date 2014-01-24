class AddPrimaryMobileToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :primary_mobile, :string
    add_column :trials, :task_time, :datetime
  end
end
