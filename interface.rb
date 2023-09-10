# frozen_string_literal: true

class TrainApp

  def initialize
    @routes = []
    @stations = []
  end

  def action
    loop do
      show_actions
      choice = gets.chomp.to_i

      case choice
      when 0
        break
      when 1
        create_station
      when 2
        create_train
      when 3
        create_car
      when 4
        add_wagon_to_train
      when 5
        remove_wagon_from_train
      when 6
        move_train_to_station
      when 7
        list_stations
      when 8
        list_trains_on_station
      when 9
        list_all_trains
      else
        show_actions_prompt
      end
    end
  end

  private

  def show_actions
    print("
    Введите номер команды:
    0. Выход
    1. Создать станцию
    2. Создать поезд
    3. Создать вагон
    4. Прицепить вагон к поезду
    5. Отцепить вагон от поезда
    6. Поместить поезд на станцию
    7. Просмотреть список станций
    8. Просмотреть список поездов находящихся на станции
    9. Список всех поездов
    >>".chomp)
  end

  def create_station
    puts 'Введите название станции'
    name = gets.chomp
    @stations << Station.new(name)
    puts "Построена станция #{name}"
  end

  def create_route
    list_stations
    puts 'Введите начальную станцию:'
    first_station_name = gets.chomp
    first_station = @stations.find { |station| station.name = first_station_name }
    puts 'Введите конечную станцию:'
    last_station_name = gets.chomp
    last_station = @stations.find { |station| station.name = last_station_name }
    @routes << Route.new(first_station, last_station)
  end

  def add_station; end

  def create_train
    puts 'C каким номером?'
    number = gets.chomp
    puts '1 - пассажирский, 2 - грузовой'
    choice = gets.chomp.to_i
    case choice
    when 1
      PassengerTrain.new(number)
      puts "Создан пассажирский поезд №#{number}"
    when 2
      CargoTrain.new(number)
      puts "Создан грузовой поезд №#{number}"
    else
      puts 'Поезд не создан. Введите 1 или 2'
    end
  end

  def create_car
    puts 'Создаем вагон.'
    puts 'Введите номер вагона:'
    number = gets.chomp

    puts 'Выберите тип вагона:'
    puts '1 - пассажирский, 2 - грузовой'

    choice = gets.chomp.to_i
    case choice
    when 1
      PassengerCar.new(number)
    when 2
      CargoCar.new(number)
    else
      puts 'Вагон не создан. Введите 1 или 2'
      return
    end

    puts("Создан новый вагон <#{Car.list.last.number}>")
  end

  def add_wagon_to_train
    puts 'Добавляем вагон поезду. Выберите поезд:'
    list_all_trains
    train = Train.list[gets.chomp.to_i]

    puts 'Выберите вагон:'
    print_cars
    train.add_car(Car.list[gets.chomp.to_i])

    puts("Изменен состав поезда <#{train.number}>")
  end

  def remove_wagon_from_train
    puts 'Отцепляем вагон от поезда. Выберите поезд:'
    train = Train.list[gets.chomp.to_i]

    puts 'Выберите вагон:'
    train.remove_car(train.cars[gets.chomp.to_i])

    puts("Изменен состав поезда <#{train.number}>")
  end

  def move_train_to_station
    if !Train.list
      puts 'Сначала Сначала создайте поезд'
    elsif @stations.empty?
      puts 'Сначала создайте станцию'
    else
      puts 'Какой поезд?'
      train = Train.list[gets.chomp.to_i]
      if train.nil?
        puts 'Поезда с таким номером нет'
      else
        puts 'На какую станцию? (название)'
        name = gets.chomp
        station = @stations.detect { |station| station.name == name }
        if station.nil?
          puts 'Такой станции нет'
        else
          station.get_train(train)
        end
      end
    end
  end

  def list_stations
    puts 'Список станций:'
    @stations.each { |station| puts station.name }
  end

  def list_trains_on_station
    if @stations.empty?
      puts 'Сначала создайте станцию'
    else
      puts 'На какой? (название)'
      name = gets.chomp
      station = @stations.detect { |station| station.name == name }
      if station.nil?
        puts 'Такой станции нет'
      else
        station.show_trains
      end
    end
  end

  def list_all_trains
    Train.list.each_with_index { |v, i| puts "#{i}. #{v.number}, #{v.type}" }
  end
  def print_cars
    Car.list.each_with_index { |v, i| puts "#{i}. #{v.number}, #{v.type}" }
  end

  def show_actions_prompt
    puts 'Необходимо выбрать один из предложенных вариантов'
  end
end
