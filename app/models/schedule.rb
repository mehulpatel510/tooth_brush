class Schedule < ApplicationRecord
  validates :patient_id, presence: true
  validates :doctor_id, presence: true
  validates :schedule_slot, presence: true
  validates :duration, presence: true

  belongs_to :patient, class_name: "User"
  belongs_to :doctor, class_name: "User"

  has_many :taskdetails, foreign_key: :schedule_id

  def index
    @schedules = current_user.schedules.order(complete_date: :DESC)
    render "index"
  end

  def patient_name
    User.find(patient_id).full_name
  end

  def doctor_name
    User.find(doctor_id).full_name
  end

  def self.of_user(user)
    if user.user_role == "doctor"
      all.where(doctor_id: user.id)
    else
      all.where(patient_id: user.id)
    end
  end

  def patient_performance()
    no_of_days = (self.complete_date - self.assign_date + 1).to_i
    schedule_slot = self.schedule_slot
    no_of_slots = (schedule_slot.delete '[]""').split().count
    no_of_tasks = no_of_days * no_of_slots
    no_of_completed_task = Taskdetail.where(schedule_id: self.id).count
    no_of_days_till_date = (Date.today() - self.assign_date + 1).to_i
    no_of_expected_task = no_of_days_till_date * no_of_slots
    performance = no_of_completed_task.to_f / no_of_expected_task
    return performance, no_of_completed_task, no_of_expected_task
  end
end
