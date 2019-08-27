require_relative 'patient'

class Room
  attr_reader :patients
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @capacity = attributes[:capacity]
    @patients = []
  end

  def full?
    @capacity == @patients.size
  end

  def add(patient)
    if full?
      # We can `raise` or `fail` our own errors in Ruby.
      # This can be useful when we implement checks,
      # as we might not want our code to continue running.
      raise Exception, "Room is full!"
    else
      @patients << patient
      # The patient needs to be assigned a room.
      # We do this when we add the patient to the room.
      # What does `self` refer to in this bit of code?
      # `self` refers to the instance of Room that we call the #add method on.
      patient.room = self
    end
  end
end

# RAISING/FAILING EXCEPTIONS
# We can also rescue errors in our code.
# Sometimes we don't want the program to stop executing,
# but we would like to get notified about the errors that
# can happen.
# In rails we'll have a log that captures all the Exceptions that
# happen when we run our code.

# room = Room.new(capacity: 2)
# patient_1 = Patient.new(name: "john")
# patient_2 = Patient.new(name: "jane")
# patient_3 = Patient.new(name: "george")

# room.add(patient_1)
# room.add(patient_2)

# begin
# room.add(patient_3)
# rescue Exception
#   puts "We had an error, but instead of crashing we puts a message"
# end

# puts "We rescued the error and this line of code should run."

# SELF
# room = Room.new(capacity: 2)
# patient = Patient.new(name: "john")

# The add method will assign "self" to the patient.
# The `self` in the add method refers to the instance of Room that
# we assigned to the `room` variable.
# room.add(patient)
# p patient.room
# #=> will print the instance of Room that we assigned to the `room` variable
