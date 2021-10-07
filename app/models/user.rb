class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :schedules, foreign_key: :patient_id
  has_many :schedules, foreign_key: :doctor_id

  def full_name
    first_name + " " + last_name
  end

  def patient_name
    User.find(patient_id).full_name
  end

  def self.patients
    where(user_role: "patient")
  end

  def self.doctors
    where(user_role: "doctor")
  end
end
