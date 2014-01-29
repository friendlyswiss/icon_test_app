class RemoveTestDeviceFromSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :test_device, :string
  end
end
