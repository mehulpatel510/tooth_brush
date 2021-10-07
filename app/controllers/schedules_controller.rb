class SchedulesController < ApplicationController
  before_action :ensure_user_logged_id

  def index
    find_users_shedules()
    check_schedules_status()
    if current_user == nil
      redirect_to home_path
    end
    show()
  end

  def show
    find_users_shedules()
    check_schedules_status()
    @schedules = @schedules.order(:id)

    if @user_role == "doctor"
      render "doctor_dashboard"
    else
      render "patient_dashboard"
    end
  end

  def edit
    find_users_shedules()
    @schedule_id = params[:id].to_i
    @field = params[:field]
    @button = params[:button]
    @user_role = current_user.user_role

    if @button == "save"
      @schedule = @schedules.find(@schedule_id)
      if @field == "duration"
        @schedule.duration = params[:duration]
      elsif @field == "assign_date"
        @schedule.assign_date = params[:assign_date]
      elsif @field == "complete_date"
        @schedule.complete_date = params[:complete_date]
      elsif @field == "schedule" && params[:schedule]
        @schedule.schedule = params[:schedule]
      end
      @schedule.save!
    end
    show()
  end

  def create
    patient_id = params[:patient_id]
    doctor_id = current_user.id
    schedule = params[:schedule]
    duration = params[:duration]
    assign_date = params[:assign_date]
    complete_date = params[:complete_date]
    status = true
    new_schedule = Schedule.new(
      patient_id: patient_id,
      doctor_id: doctor_id,
      schedule: schedule,
      duration: duration,
      assign_date: assign_date,
      complete_date: complete_date,
      status: true,
    )
    if !new_schedule.save
      flash[:error] = new_schedule.errors.full_messages.join(", ")
    else
      flash[:info] = "Schedule Added Successfully!"
    end
    redirect_to schedules_path
  end

  def update
    schedule_id = params[:id]
    status = params[:status] ? params[:status] : false
    schedule = Schedule.of_user(current_user).find(schedule_id)
    schedule.status = status
    schedule.save!
    redirect_to schedules_path
  end

  def destroy
    schedule_id = params[:id]
    schedule = Schedule.of_user(current_user).find(schedule_id)
    schedule.destroy
    flash[:info] = "Schedule deleted Successfully!"
    redirect_to schedules_path
  end

  def summary
    find_users_shedules()
    check_schedules_status()
    render "summary"
  end

  def find_users_shedules
    if current_user.user_role == "patient"
      @user_role = "patient"
      @schedules = Schedule.where(patient_id: current_user.id)
    elsif current_user.user_role == "doctor"
      @user_role = "doctor"
      @schedules = Schedule.where(doctor_id: current_user.id)
    end
  end

  def check_schedules_status
    @status = params[:status] == nil ? session[:status] : params[:status]
    @status = (@status == nil || @status.empty?) ? "true" : @status
    session[:status] = @status
    if @status != "both"
      @schedules = @schedules.where(status: @status)
    end
  end
end
