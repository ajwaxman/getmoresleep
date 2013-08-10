class User < ActiveRecord::Base
  attr_accessible :access_token, :first_name, :image_url, :last_name, :password_digest, :x_id
  validates_uniqueness_of :x_id
end
