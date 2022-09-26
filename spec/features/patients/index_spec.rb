require 'rails_helper'

RSpec.describe 'Patient Index Page' do
  describe 'As a visitor' do
    describe 'When I visit the patient index page' do
      before :each do
        @patient1 = Patient.create!(name: "Katie Bryce", age: 15)
        @patient2 = Patient.create!(name: "Jeremiah Tate", age: 50)
        @patient3 = Patient.create!(name: "Bonnie Crasnoff", age: 40)
        @patient4 = Patient.create!(name: "George O'Malley", age: 32)
        @patient5 = Patient.create!(name: "Maya Bishop", age: 18)
      end

      it 'I see the names of all adult patients (age is greater than 18)' do
        visit patients_path

        expect(page).to have_content("Bonnie Crasnoff")
        expect(page).to have_content("George O'Malley")
        expect(page).to have_content("Jeremiah Tate")
        expect(page).to_not have_content("Katie Bryce")
        expect(page).to_not have_content("Maya Bishop")
      end

      it 'I see the names are in ascending alphabetical order (A - Z; not accounting for capitalization)' do
        visit patients_path

        expect("Bonnie Crasnoff").to appear_before("George O'Malley")
        expect("George O'Malley").to appear_before("Jeremiah Tate")
      end
    end
  end
end
