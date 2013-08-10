class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :image_url
      t.string :x_id
      t.string :access_token
      t.string :password_digest

      t.timestamps
    end
  end
end
