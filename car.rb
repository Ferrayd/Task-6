# frozen_string_literal: true

class Car
  attr_reader :number, :type
  include Information

  def initialize(number)
    @number = number
    self.class.all << self
  end

  def self.all
    @@all ||= []
  end
end
