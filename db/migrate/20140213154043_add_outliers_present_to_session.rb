class AddOutliersPresentToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :outliers_present, :boolean
  end
end
