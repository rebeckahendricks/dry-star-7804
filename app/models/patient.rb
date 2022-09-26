class Patient < ApplicationRecord
  has_many :patient_doctors
  has_many :doctors, through: :patient_doctors

  validates :name, presence: true
  validates :age, presence: true

  def self.adult_patients
    where('age > 18')
  end

  def self.sort_by_name
    order(:name)
  end
end
