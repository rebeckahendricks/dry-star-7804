require 'rails_helper'

RSpec.describe Patient do
  describe 'relationships' do
    it {should have_many :patient_doctors}
    it {should have_many(:doctors).through(:patient_doctors)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
  end

  describe 'class methods' do
    before :each do
      @patient1 = Patient.create!(name: "Katie Bryce", age: 15)
      @patient2 = Patient.create!(name: "Jeremiah Tate", age: 50)
      @patient3 = Patient.create!(name: "Bonnie Crasnoff", age: 40)
      @patient4 = Patient.create!(name: "George O'Malley", age: 32)
      @patient5 = Patient.create!(name: "Maya Bishop", age: 18)
    end

    describe 'adult_patients' do
      it 'can list only patients over the age of 18' do
        expect(Patient.adult_patients).to eq([@patient2, @patient3, @patient4])
      end
    end

    describe 'sort_by_name' do
      it 'can sort patients by name alphabetically' do
        expect(Patient.sort_by_name).to eq([@patient3, @patient4, @patient2, @patient1, @patient5])
      end
    end
  end
end
