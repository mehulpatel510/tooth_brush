class CreateTaskdetails < ActiveRecord::Migration[6.1]
  def change
    create_table :taskdetails do |t|
      t.integer :schedule_id
      t.date :task_date
      t.text :schedule_slot
      t.integer :duration

      t.timestamps
    end
  end
end
