class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.integer :sequence_order
      t.string :target_form
      t.string :style
      t.string :color
      t.datetime :task_start
      t.datetime :task_end
      t.boolean :task_success

      t.timestamps
    end
  end
end
