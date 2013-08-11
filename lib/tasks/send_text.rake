namespace :cron do
  desc "Send a text if user went to bed late last night"
  task :sleep_text => :environment do
    User.all.each do |user| 
      @sleep = HTTParty.get("https://jawbone.com/nudge/api/users/@me/sleeps", :headers => { "Authorization" => user.access_token })
      @sleep_time = @sleep.parsed_response["data"]["items"][0]["details"]["asleep_time"]
      if user.trigger_time(user.too_late_time) < @sleep_time
        user.send_text
      else
        user.send_text
      end
    end
  end
end