class User < ActiveRecord::Base
  attr_accessible :access_token, :first_name, :image_url, :last_name, :password_digest, :x_id
  validates_uniqueness_of :x_id

  def send_text
    number = "216-533-1493"
    account_sid = ENV["TWILIO_SID"] # received after creating an account with Twilio
    auth_token = ENV["TWILIO_AUTH_TOKEN"] # same as above
    @client = Twilio::REST::Client.new account_sid, auth_token # create a Twilio client (used to send messages)
    @client.account.sms.messages.create( # method on client to create an sms message
      :from => '6465024533', # my Twilio number in actual code
      :to => number, # user's number
      :body => 'You were up till 3am last night! Go get some sleep tonight!' # text message content
    )
  end

end
