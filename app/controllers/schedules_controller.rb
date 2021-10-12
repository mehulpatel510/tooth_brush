class SchedulesController < ApplicationController
  before_action :ensure_user_logged_id

  def index
    find_users_shedules()
    check_active_schedules()
    if current_user == nil
      redirect_to home_path
    end
    show()
  end

  def show
    find_users_shedules()
    check_active_schedules()
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
      elsif @field == "schedule_slot" && params[:schedule_slot]
        @schedule.schedule_slot = params[:schedule_slot]
      end
      @schedule.save!
    end
    show()
  end

  def create
    patient_id = params[:patient_id]
    doctor_id = current_user.id
    schedule_slot = params[:schedule_slot]
    duration = params[:duration]
    assign_date = params[:assign_date]
    complete_date = params[:complete_date]
    active_schedule = true
    new_schedule = Schedule.new(
      patient_id: patient_id,
      doctor_id: doctor_id,
      schedule_slot: schedule_slot,
      duration: duration,
      assign_date: assign_date,
      complete_date: complete_date,
      active_schedule: true,
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
    active_schedule = params[:active_schedule] ? params[:active_schedule] : false
    schedule = Schedule.of_user(current_user).find(schedule_id)
    schedule.active_schedule = active_schedule
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
    check_active_schedules()
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

  def check_active_schedules
    @active_schedule = params[:active_schedule] == nil ? session[:active_schedule] : params[:active_schedule]
    @active_schedule = (@active_schedule == nil || @active_schedule.empty?) ? "true" : @active_schedule
    session[:active_schedule] = @active_schedule
    if @active_schedule != "both"
      @schedules = @schedules.where(active_schedule: @active_schedule)
    end
  end
end
