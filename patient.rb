class Patient
  attr_reader :name
  attr_accessor :room

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @cured = attributes[:cured] || false
    @room = attributes[:room]
  end

  def cure
    @cured = true
  end
end
