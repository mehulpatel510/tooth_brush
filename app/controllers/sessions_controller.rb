class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_id

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.active_user == true
      session[:current_user_id] = user.id
      if user.user_role == "admin"
        redirect_to users_path
      else
        redirect_to schedules_path
      end
    else
      flash[:error] = "Invalid username or password!"
      redirect_to new_sessions_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to home_path
  end
end
