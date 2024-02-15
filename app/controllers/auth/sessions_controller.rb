class Auth::SessionsController < ApplicationController

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to pokemons_path, notice: 'Welcome!!!'
    else
      redirect_to new_session_path, alert: 'Fail to login'
    end
  end

  private

  def session_params
    params.require(:user).permit :email, :password
  end
end
