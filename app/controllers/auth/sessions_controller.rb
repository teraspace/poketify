class Auth::SessionsController < ApplicationController
  skip_before_action :protected_pages, only: [ :new, :create ]

  def index
    redirect_to pokemons_path
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      Current.user = @user
      redirect_to pokemons_path, notice: 'Welcome!'
    else
      redirect_to new_session_path, alert: 'Fail to login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to pokemons_path, notice: 'Bye'
  end

  private

  def session_params
    params.require(:user).permit :email, :password
  end
end
