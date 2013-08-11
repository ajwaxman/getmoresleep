class Changecolumns < ActiveRecord::Migration
  def change
    change_column :users, :too_late_time, :string
    change_column :users, :reminder_time, :string
  end
end
