class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :patient_doctors
  has_many :patients, through: :patient_doctors

  validates :name, presence: true
  validates :specialty, presence: true
  validates :university, presence: true
  validates :hospital_id, presence: true

  def patient_count
    patients.count
  end

  def self.order_by_patient_count
    joins(:patient_doctors)
    .select("doctors.*, count(patient_doctors) as patient_count")
    .group('doctors.id')
    .order('patient_count desc')
  end
end
