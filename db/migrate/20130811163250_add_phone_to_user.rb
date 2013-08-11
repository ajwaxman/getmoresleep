class AddPhoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :too_late_time, :datetime
    add_column :users, :reminder_time, :datetime
  end
end
