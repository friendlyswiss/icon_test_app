class RemoveTaskPrimaryBrowserFromSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :primary_browser, :string
  end
end
