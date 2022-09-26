class PatientsController < ApplicationController
  def index
    @adult_patients = Patient.adult_patients.sort_by_name
  end
end
