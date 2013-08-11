class SessionsController < ApplicationController
  def new
    if current_user
      @me = HTTParty.get("https://jawbone.com/nudge/api/users/@me", :headers => { "Authorization" => User.find(current_user).access_token })
      @image = @me.parsed_response["data"]["image"]
      @sleep = HTTParty.get("https://jawbone.com/nudge/api/users/@me/sleeps", :headers => { "Authorization" => User.find(current_user).access_token })
      @sleep_image = @sleep.parsed_response["data"]["items"][0]["snapshot_image"]
      @wake_time = @sleep.parsed_response["data"]["items"][0]["details"]["awake_time"]
      @sleep_time = @sleep.parsed_response["data"]["items"][0]["details"]["asleep_time"]
      @sleep_length = @sleep.parsed_response["data"]["items"][0]["details"]["duration"]


    end
  end

  def create
    code = params["code"]
    json = HTTParty.post("https://jawbone.com/auth/oauth2/token", body: {client_id: ENV["JAWBONE_CLIENT_ID"], client_secret: ENV["JAWBONE_CLIENT_SECRET"], grant_type: 'authorization_code', code: code }).body
    result = JSON.parse(json)
    access_token = "Bearer " + result["access_token"]
    @user = HTTParty.get("https://jawbone.com/nudge/api/users/@me/sleeps", :headers => { "Authorization" => access_token })["data"]
    xid = @user["xid"]

    if User.find_by_x_id(xid)
      user = User.find_by_x_id(xid)
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      user = User.new
      user.first_name = @user["first"]
      user.last_name = @user["last"]
      user.image_url = @user["image"]
      user.x_id = @user["xid"]
      user.access_token = access_token
      if user.save
        session[:user_id] = user.id
        redirect_to root_url, notice: "Logged in!"
      else
        flash.now.alert = "Sorry something went wrong. Please try again."
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
