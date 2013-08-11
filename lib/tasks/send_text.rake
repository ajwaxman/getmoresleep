namespace :cron do
  desc "Send a text if user went to bed late last night"
  task :sleep_text => :environment do
    User.find(1).send_text
  end
end