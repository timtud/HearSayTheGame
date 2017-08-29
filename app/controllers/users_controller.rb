class UsersController < DeviseController
  def show
    @user = User.find(params[:id])
  end
end
