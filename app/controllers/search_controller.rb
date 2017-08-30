class SearchController < ApplicationController

  def index
    @users = User.where("handle ILIKE ?", "%#{params["q"]}%")
  end

end
