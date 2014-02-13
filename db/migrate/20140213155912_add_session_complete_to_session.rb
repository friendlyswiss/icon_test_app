class AddSessionCompleteToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :session_complete, :boolean
  end
end
