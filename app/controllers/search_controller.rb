class SearchController < ApplicationController

  def index
    @users = User.where("handle ILIKE ? AND first_name ILIKE ?", "%#{params["q"]}%", "%#{params["q"]}%")

    if @users.empty?
      redirect_to users_search_path
    end
  end

end
