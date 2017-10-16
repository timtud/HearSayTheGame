class RelationshipsController < ApplicationController
  include BadgeCreator

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end

  def update
    if @relationship.save
      #Achievement
      check_achievements("relationship")
    end
  end
end