require 'csv'
require_relative 'room'

class RoomRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @rooms = []
    @next_id = 1
    load_csv
  end

  # We need the find method, and it no longer searches for index.
  # It's more accurate to search for the ID.
  def find(id)
    @rooms.find { |room| room.id == id }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, csv_options) do |row|
      row[:id]    = row[:id].to_i          # Convert column to Integer
      row[:capacity] = row[:capacity].to_i
      @rooms << Room.new(row)
      @next_id = row[:id]
    end
    @next_id += 1
  end

end
