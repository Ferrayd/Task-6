# frozen_string_literal: true

class Car
  attr_reader :number, :type
  include Information

  def initialize(number)
    @number = number
    self.class.list << self
  end

  def self.list
    @@list ||= []
  end
end

class PassengerCar < Car
  def initialize(number)
    super
    @type = :passenger
  end
end

class CargoCar < Car
  def initialize(number)
    super
    @type = :cargo
  end
end
