class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_id
  @show_user = "both"

  def index
    @show_user = session[:show_user]
    @show_user = (@show_user == nil || @show_user.empty?) ? "both" : @show_user
    show()
  end

  def manage
    ensure_user_logged_id()
    if current_user.user_role != "admin"
      render session_path
    end
    find_users_by_role()
    @users = User.order(:id)
    render "/users/manage"
  end

  def find_users_by_role
    @show_user = params[:show_user] == nil ? session[:show_user] : params[:show_user]
    @show_user = (@show_user == nil || @show_user.empty?) ? "both" : @show_user
    session[:show_user] = @show_user
    if @show_user && @show_user != "both"
      @users = User.where(user_role: @show_user)
    else
      @users = User.all
    end
  end

  def find_user_by_status
    @status = params[:status] == nil ? session[:status] : params[:status]
    @status = (@status == nil || @status.empty?) ? "both" : @status 
    session[:status] = @status
    if @status != "both"
      @users = User.where(status: @status)
    else
      @users = User.all
    end
  end

  def show
    find_user_by_status()
    if current_user
      if current_user.user_role == "admin"
        render "admin_dashboard"
      elsif current_user.user_role == "doctor"
        redirect_to schedules_path
      end
    else
      render "new"
    end
  end

  def new
    if current_user && current_user.user_role == "admin"
      ensure_user_logged_id()
    end
    render "new"
  end

  def create
    @user_role = "patient"

    if current_user && current_user.user_role == "admin"
      @user_role = "doctor"
    end
    new_user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: (params[:password]),
      user_role: @user_role,
      status: true,
    )
    if !new_user.save
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    else
      if @user_role == "doctor"
        flash[:info] = "Successfully doctor added!"
        manage()
      else
        flash[:info] = "Congrats, Successfully Registered! Please, login to continue!"
        redirect_to home_path
      end
    end
  end

  def update
    user_id = params[:id]
    status = params[:status] ? params[:status] : false
    user = User.find(user_id)
    user.status = status
    user.save!
    manage()
  end

  def edit
    @user_id = params[:id].to_i
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @user_role = params[:user_role]

    @button = params[:button]
    if @button == "save"
      @user = User.find(@user_id)
      @user.first_name = @first_name
      @user.last_name = @last_name
      @user.email = @email
      @user.user_role = @user_role == nil || @user_role.empty? ? @user.user_role : @user_role
      @user.save!
    end
    manage()
  end

  def destroy
    id = params[:id]
    user = User.find(id)
    user.destroy
    flash[:info] = "User deleted Successfully!"
    manage()
  end
end
