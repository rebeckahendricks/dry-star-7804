class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])
    patient = Patient.find(params[:patient_id])
    patient_doctor = PatientDoctor.find_by(patient_id: patient.id, doctor_id: @doctor.id)
    patient_doctor.destroy
    redirect_to doctor_path(@doctor)
  end
end
