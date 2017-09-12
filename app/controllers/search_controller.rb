class SearchController < ApplicationController

  def index
    @users = User.where("handle ILIKE ? OR first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ? OR location ILIKE ?", "%#{params["q"]}%", "%#{params["q"]}%", "%#{params["q"]}%", "%#{params["q"]}%", "%#{params["q"]}%")
    if @users.empty?
      redirect_to users_search_path
    end
  end

end
