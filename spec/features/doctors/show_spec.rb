require 'rails_helper'

RSpec.describe 'Doctors Show Page' do
  describe 'As a visitor' do
    describe 'When I visit a doctors show page' do
      before :each do
        @hospital1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
        @hospital2 = Hospital.create!(name: "Mercy West Hospital")

        @doctor1 = Doctor.create!(name: "Meredith Grey", specialty: "General Surgery", university: "University of Virginia", hospital_id: @hospital1.id)
        @doctor2 = Doctor.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Johns Hopkins University", hospital_id: @hospital1.id)
        @doctor3 = Doctor.create!(name: "Callie Torres", specialty: "Orthopedic Surgery", university: "University of Arizona", hospital_id: @hospital2.id)

        @patient1 = Patient.create!(name: "Katie Bryce", age: 15)
        @patient2 = Patient.create!(name: "Bonnie Crasnoff", age: 40)
        @patient3 = Patient.create!(name: "George O'Malley", age: 32)
        @patient4 = Patient.create!(name: "Jeremiah Tate", age: 50)

        @patient_doctor1 = PatientDoctor.create!(doctor_id: @doctor1.id, patient_id: @patient1.id)
        @patient_doctor2 = PatientDoctor.create!(doctor_id: @doctor1.id, patient_id: @patient2.id)
        @patient_doctor3 = PatientDoctor.create!(doctor_id: @doctor1.id, patient_id: @patient3.id)
        @patient_doctor5 = PatientDoctor.create!(doctor_id: @doctor2.id, patient_id: @patient3.id)
        @patient_doctor6 = PatientDoctor.create!(doctor_id: @doctor2.id, patient_id: @patient4.id)
      end

      it 'I see all of that doctors information including name, specialty, university where they got their doctorate' do
        visit doctor_path(@doctor1)

        expect(page).to have_content("Meredith Grey")
        expect(page).to have_content("Specialty: General Surgery")
        expect(page).to have_content("University: University of Virginia")
        expect(page).to_not have_content("Miranda Bailey")
      end

      it 'I see the name of the hospital where this doctor works' do
        visit doctor_path(@doctor1)

        expect(page).to have_content("Hospital: Grey Sloan Memorial Hospital")
        expect(page).to_not have_content("Hospital: Mercy West Hospital")
      end

      it 'I see the names of all the patients this doctor has' do
        visit doctor_path(@doctor1)

        expect(page).to have_content("Katie Bryce")
        expect(page).to have_content("Bonnie Crasnoff")
        expect(page).to have_content("George O'Malley")
        expect(page).to_not have_content("Jeremiah Tate")
      end
    end
  end
end
