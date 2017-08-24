class UsersController < DeviseController
  def show
    @user = current_user
  end
end
