require 'rails_helper'

RSpec.describe Doctor do
  describe 'relationships' do
    it {should belong_to :hospital}
    it {should have_many :patient_doctors}
    it {should have_many(:patients).through(:patient_doctors)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :specialty}
    it {should validate_presence_of :university}
    it {should validate_presence_of :hospital_id}
  end

  before :each do
    @hospital1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")

    @doctor1 = Doctor.create!(name: "Meredith Grey", specialty: "General Surgery", university: "University of Virginia", hospital_id: @hospital1.id)
    @doctor2 = Doctor.create!(name: "Alex Karev", specialty: "Pediatric Surgery", university: "University of Arizona", hospital_id: @hospital1.id)
    @doctor3 = Doctor.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Johns Hopkins University", hospital_id: @hospital1.id)

    @patient1 = Patient.create!(name: "Katie Bryce", age: 15)
    @patient2 = Patient.create!(name: "Bonnie Crasnoff", age: 40)
    @patient3 = Patient.create!(name: "George O'Malley", age: 32)
    @patient4 = Patient.create!(name: "Jeremiah Tate", age: 50)
    @patient5 = Patient.create!(name: "Denny Duquette", age: 39)
    @patient6 = Patient.create!(name: "Rebecca Pope", age: 32)
    @patient7 = Patient.create!(name: "Zola Shepherd", age: 2)

    @patient_doctor1 = PatientDoctor.create!(doctor_id: @doctor1.id, patient_id: @patient1.id)
    @patient_doctor2 = PatientDoctor.create!(doctor_id: @doctor1.id, patient_id: @patient2.id)
    @patient_doctor3 = PatientDoctor.create!(doctor_id: @doctor1.id, patient_id: @patient3.id)
    @patient_doctor4 = PatientDoctor.create!(doctor_id: @doctor2.id, patient_id: @patient2.id)
    @patient_doctor5 = PatientDoctor.create!(doctor_id: @doctor2.id, patient_id: @patient3.id)
    @patient_doctor6 = PatientDoctor.create!(doctor_id: @doctor2.id, patient_id: @patient4.id)
    @patient_doctor7 = PatientDoctor.create!(doctor_id: @doctor2.id, patient_id: @patient5.id)
    @patient_doctor8 = PatientDoctor.create!(doctor_id: @doctor3.id, patient_id: @patient6.id)
    @patient_doctor9 = PatientDoctor.create!(doctor_id: @doctor3.id, patient_id: @patient7.id)
  end

  describe 'class methods' do
    describe '.order_by_patient_count' do
      it 'can order doctors by the number of patients associated with each doctor' do
        expect(Doctor.order_by_patient_count).to eq([@doctor2, @doctor1, @doctor3])
      end
    end
  end
  
  describe 'instance methods' do
    describe '#patient_count' do
      it 'can count the number of patients associated with a doctor' do
        expect(@doctor1.patient_count).to eq(3)
        expect(@doctor2.patient_count).to eq(4)
        expect(@doctor3.patient_count).to eq(2)
      end
    end
  end
end
