class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.text :schedule
      t.integer :duration
      t.date :assign_date
      t.date :complete_date
      t.boolean :active_schedule

      t.timestamps
    end
  end
end
