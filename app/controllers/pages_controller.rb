class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :leaderboard]

  def home
  end

  def leaderboard
  end
end
