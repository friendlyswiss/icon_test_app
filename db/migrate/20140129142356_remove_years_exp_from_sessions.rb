class RemoveYearsExpFromSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :years_exp, :integer
    add_column :sessions, :years_exp, :string
  end
end
