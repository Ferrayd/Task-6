# frozen_string_literal: true

class Train
  attr_reader :number, :cars, :type, :speed, :route, :station
  include Counter
  include Information

  def initialize(number)
    @number = number
    @speed = 0
    @cars = []
    register_instance
    self.class.list << self
  end

  def self.list
    @@list ||= []
  end

  def self.find(number)
    result = list.select { |train| train if train.number == number }
    result.empty? ? nil : result.first
  end

  def stop
    self.speed = 0
  end

  def add_car(car)
    @cars << car if !@cars.member?(car) && car.type == type
  end

  def remove_car(car)
    @cars.delete(car) if car.type == type
  end

  def take_route(route)
    self.route = route
    puts "Поезду №#{number} задан маршрут #{route.name}"
  end

  def go_to(station)
    if route.nil?
      puts 'Без маршрута поезд заблудится.'
    elsif @station == station
      puts "Поезд №#{@number} и так на станции #{@station.name}"
    elsif route.stations.include?(station)
      @station&.send_train(self)
      @station = station
      station.get_train(self)
    else
      puts "Станция #{station.name} не входит в маршрут поезда №#{number}"
    end
  end

  def stations_around
    if route.nil?
      puts 'Маршрут не задан'
    else
      station_index = route.stations.index(station)
      puts "Сейчас поезд на станции #{station.name}."
      puts "Предыдущая станция - #{route.stations[station_index - 1].name}." if station_index != 0
      puts "Следующая - #{route.stations[station_index + 1].name}." if station_index != route.stations.size - 1
    end
  end
end

class PassengerTrain < Train
  def initialize(number)
    super
    @type = :passenger
  end
end

class CargoTrain < Train
  def initialize(number)
    super
    @type = :cargo
  end
end
