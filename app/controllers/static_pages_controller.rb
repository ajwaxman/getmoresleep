class StaticPagesController < ApplicationController
  def welcome
  end

  def auth
    code = params["code"]
    json = HTTParty.post("https://jawbone.com/auth/oauth2/token", body: {client_id: ENV["JAWBONE_CLIENT_ID"], client_secret: ENV["JAWBONE_CLIENT_SECRET"], grant_type: 'authorization_code', code: code }).body
    result = JSON.parse(json)
    access_token = "Bearer " + result["access_token"]
    @user = HTTParty.get("https://jawbone.com/nudge/api/users/@me", :headers => { "Authorization" => access_token })
    raise params
    # redirect_to root_path
  end
end
