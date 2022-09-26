require 'rails_helper'

RSpec.describe PatientDoctor do
  describe 'relationships' do
    it {should belong_to :patient}
    it {should belong_to :doctor}
  end

  describe 'validations' do
    it {should validate_presence_of :patient_id}
    it {should validate_presence_of :doctor_id}
  end
end
