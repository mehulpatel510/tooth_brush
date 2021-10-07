class Taskdetail < ApplicationRecord
  belongs_to :schedule, class_name: "Schedule"

  validates :schedule_id, uniqueness: { scope: [:task_date, :schedule_slot], message: " task has already been completed!" }
end
