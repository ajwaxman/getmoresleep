class UsersController < ApplicationController
  def new

  end
  
  def create
    @user = User.new
    if @user.save
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  def show

      @user = HTTParty.get("https://jawbone.com/nudge/api/users/@me", :headers => { "Authorization" => current_user.access_token })
      @image = @user.parsed_response["data"]["image"]
      @sleep = HTTParty.get("https://jawbone.com/nudge/api/users/@me/sleeps", :headers => { "Authorization" => current_user.access_token })
      @sleep_image = @sleep.parsed_response["data"]["items"][0]["snapshot_image"]
      @wake_time = @sleep.parsed_response["data"]["items"][0]["details"]["awake_time"]
      @sleep_time = @sleep.parsed_response["data"]["items"][0]["details"]["asleep_time"]
      @asleep_length = @sleep.parsed_response["data"]["items"][0]["details"]["duration"]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @unit }
    end


  end

  def send_text(user)
    user.send(text)
  end

  def set_time
    
  end

end


