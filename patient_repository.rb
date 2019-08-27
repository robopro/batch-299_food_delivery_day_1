require 'csv'
require_relative 'patient'

class PatientRepository
  # We need access to the `room_repository` when we run #load_csv.
  # So we pass it to the initialize when we instantiate our `patient_repository`
  def initialize(csv_path, room_repository)
    @csv_path = csv_path
    @room_repository = room_repository
    @patients = []
    @next_id = 1
    load_csv
  end

  def all
    @patients
  end

  def add(patient)
    patient.id = @next_id
    @patients << patient
    @next_id += 1
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, csv_options) do |row|
      row[:id]    = row[:id].to_i          # Convert column to Integer
      row[:cured] = row[:cured] == "true"  # Convert column to boolean
      patient = Patient.new(row)

      # The patient needs to know which room he is in.
      # We don't want to store just the room_id, we want
      # to store an *instance of the room*!
      # To do that we added a #find method to our RoomRepository.
      # We use the #find method to look up which room has the room_id
      # that's stored in the csv.
      # We then assign that room to the patient.
      # Then we also have to add the patient to the room.
      # (The room knows which patients are in it.)
      room = @room_repository.find(row[:room_id].to_i)
      patient.room = room
      room.add(patient)

      @patients << patient
      @next_id = row[:id]
    end
    # We need to update our @next_id to match what was in the csv.
    # We set our `@next_id` equal to the id of the latest element
    # we read from the csv, and add one.
    # Unless we didn't load anything from our csv. (`@next_id` doesn't change.)
    # See RoomRepository for alternative solution.
    @next_id = @patients.last.id + 1 unless @patients.empty?
  end
end
