require_relative 'room_repository'
require_relative 'patient_repository'

room_repository = RoomRepository.new("rooms.csv")
patient_repository = PatientRepository.new("patients.csv", room_repository)

# We p the room of the first patient in our patient repository.
p patient_repository.all.first.room

# You can write your own tests here and run
# `ruby test_scenario.rb`
