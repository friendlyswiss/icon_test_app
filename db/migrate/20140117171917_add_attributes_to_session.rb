class AddAttributesToSession < ActiveRecord::Migration
  def change
  	add_column :sessions, :test_browser, :string 
  	add_column :sessions, :test_os, :string 
  	add_column :sessions, :test_device, :string 
  	add_column :sessions, :age, :string 
  	add_column :sessions, :primary_browser, :string 
  	add_column :sessions, :primary_os, :string 
  	add_column :sessions, :years_exp, :integer 
  	add_column :sessions, :success_rate, :float
  end
end
