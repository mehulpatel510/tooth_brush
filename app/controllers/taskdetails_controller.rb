class TaskdetailsController < ApplicationController
  before_action :ensure_user_logged_id

  def index
    show()
  end

  def create
    selected_schedule = Schedule.of_user(current_user).find(params[:schedule_id].to_i)
    puts selected_schedule.id
    if selected_schedule == nil
      flash[:error] = "Invalid schedule!"
    else
      new_schedule_task = Taskdetail.new(
        schedule_id: params[:schedule_id],
        task_date: Date.today(),
        schedule_slot: params[:schedule_slot],
        duration: params[:duration],
      )
      if !new_schedule_task.save
        flash[:error] = new_schedule_task.errors.full_messages.join(", ")
      else
        flash[:info] = "Successfully Added Schedule Task!"
      end
    end
    redirect_to schedules_path
  end

  def show
    if params[:button] == nil
      @schedule_id = params[:id] == nil ? session[:schedule_id] : params[:id].to_i
      session[:schedule_id] = @schedule_id
    else
      @schedule_id = session[:schedule_id]
    end
    puts @schedule_id
    @taskdetails = Taskdetail.where(schedule_id: @schedule_id.to_i)
    if @button == nil
      @button = "save"
      @taskdetail_id = -1
    end
    render "show"
  end

  def edit
    @taskdetail_id = params[:id].to_i
    @task_date = params[:task_date]
    @schedule_slot = params[:schedule_slot]
    @duration = params[:duration]

    @button = params[:button]
    if @button == "save"
      @tasldetail = Taskdetail.find(@taskdetail_id)
      @tasldetail.task_date = @task_date
      @tasldetail.schedule_slot = @schedule_slot
      @tasldetail.duration = @duration
      @tasldetail.save!
    end
    show()
  end

  def destroy
    @taskdetail_id = params[:id]
    @tasldetail = Taskdetail.find(@taskdetail_id)
    @tasldetail.destroy
    flash[:info] = "Taskdetail deleted Successfully!"
    redirect_to taskdetails_path
  end
end
