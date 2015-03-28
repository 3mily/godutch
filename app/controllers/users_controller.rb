class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to root_path
    end
  end



  def user_params
    params.permit(:firstname, :lastname, :email, :stripe_key, :password, :password_confirmation)
  end

end