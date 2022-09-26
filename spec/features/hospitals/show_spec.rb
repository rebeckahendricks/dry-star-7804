require 'rails_helper'

RSpec.describe 'Hospital Show Page' do
  describe 'As a visitor' do
    describe 'When I visit a hospitals show page' do
      before :each do
        @hospital1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
        @hospital2 = Hospital.create!(name: "Mercy West Hospital")

        @doctor1 = Doctor.create!(name: "Meredith Grey", specialty: "General Surgery", university: "University of Virginia", hospital_id: @hospital1.id)
        @doctor2 = Doctor.create!(name: "Alex Karev", specialty: "Pediatric Surgery", university: "University of Arizona", hospital_id: @hospital1.id)
        @doctor3 = Doctor.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Johns Hopkins University", hospital_id: @hospital1.id)
        @doctor3 = Doctor.create!(name: "Derek Shepherd", specialty: "Neurology", university: "University of Pennsylvania", hospital_id: @hospital2.id)

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

      it 'I see the hospitals name' do
        visit hospital_path(@hospital1)

        expect(page).to have_content("Grey Sloan Memorial Hospital")
        expect(page).to_not have_content("Mercy West Hospital")
      end

      it 'I see the names of all doctors that work at this hospital' do
        visit hospital_path(@hospital1)

        expect(page).to have_content("Meredith Grey")
        expect(page).to have_content("Alex Karev")
        expect(page).to have_content("Miranda Bailey")
        expect(page).to_not have_content("Derek Shepherd")
      end

      it 'Next to each doctor I see the number of patients associated with the doctor' do
        visit hospital_path(@hospital1)

        within "#doctor_#{@doctor1.id}" do
          expect(page).to have_content("Patient Count: 3")
        end

        within "#doctor_#{@doctor2.id}" do
          expect(page).to have_content("Patient Count: 4")
        end

        within "#doctor_#{@doctor3.id}" do
          expect(page).to have_content("Patient Count: 2")
        end
      end

      it 'I see the list of doctors is ordered from most number of patients to least number of patients' do
        visit hospital_path(@hospital1)

        expect("Alex Karev").to appear_before("Meredith Grey")
        expect("Meredith Grey").to appear_before("Miranda Bailey")
      end
    end
  end
end
