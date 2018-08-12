require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

@all_stations = []
all_trains = []
all_routes = []

def notation
  puts 'Список существующих станций:'
  @all_stations.each { |station| puts station.name }
end

# station1 = Station.new('www')
# station2 = Station.new('eee')
# station3 = Station.new('zzz')
#
# @all_stations.push(station1)
# @all_stations.push(station2)
# @all_stations.push(station3)
#
# routes1 = Route.new(station1,station3)
# all_routes.push(routes1)
#
# routes1.add_station(station2)
#
# train1 = CargoTrain.new ("WW1-22")
# train2 = PassengerTrain.new ("WW2-33")
# all_trains.push(train1)
# all_trains.push(train2)
#
# train1.receive_train_trace_list(routes1.output)
# train2.receive_train_trace_list(routes1.output)
#
# wagon3 = CargoWagon.new(40)
# wagon4 = CargoWagon.new(50)
# wagon5 = CargoWagon.new(100)
# wagon6 = CargoWagon.new(70)
# wagon7 = CargoWagon.new(80)
#
# wagon13 = PassengerWagon.new(40)
# wagon14 = PassengerWagon.new(50)
# wagon15 = PassengerWagon.new(60)
# wagon16 = PassengerWagon.new(70)
# wagon17 = PassengerWagon.new(80)
#
#
# wagon3.filling(19)
# wagon4.filling(31)
#
# train1.wagon_coupling(wagon3)
# train1.wagon_coupling(wagon4)
# train1.wagon_coupling(wagon5)
# train1.wagon_coupling(wagon6)
# train1.wagon_coupling(wagon7)
#
# train2.wagon_coupling(wagon13)
# train2.wagon_coupling(wagon14)
# train2.wagon_coupling(wagon15)
# train2.wagon_coupling(wagon16)
# train2.wagon_coupling(wagon17)

# rubocop:disable Metrics/BlockLength

loop do
  puts '1. Создать станцию'
  puts '2. Создать поезд'
  puts '3. Создать маршрут'
  puts '4. Управление маршрутами'
  puts '5. Назначить маршрут поезду'
  puts '6. Добавить вагон к поезду'
  puts '7. Отцепить вагон от поезда'
  puts '8. Переместить поезд по маршруту'
  puts '9. Просмотреть список станций'
  puts '10. Просмотреть список поездов на станции'
  puts '11. Просмотреть список вагонов'
  puts '12. Просмотреть список поездов на станции'
  puts '13. Занять место или обьем в вагоне'
  puts '0. Выход'
  puts 'Выберите вариант: '
  input = gets.to_i
  break if input.zero?

  if input == 1
    puts 'Введите название станции'
    station_name = gets.chomp
    station_variable = Station.new(station_name)
    @all_stations.push(station_variable)
  end

  if input == 2
    begin
      puts 'Введите номер поезда'
      train_number = gets.chomp
      puts '1. Поезд грузовой'
      puts '2. Поезд пассажирский'
      input_train = gets.chomp
      train_variable = if input_train == '1'
                         CargoTrain.new(train_number)
                       else
                         PassengerTrain.new(train_number)
                       end
      all_trains.push(train_variable)
      puts "Поезд #{train_variable.number} создан, тип поезда #{train_variable.type}"
    rescue RuntimeError => e
      puts "Что-то пошло не так, повторите ввод. Ошибка: #{e.inspect}"
      retry
    end
  end

  if input == 3
    puts 'Чтобы создать маршрут необходимо указать начальную и конечную станцию !'
    notation
    puts 'Введите поочередно название начальной и конечной станции маршрута'
    starting_station = gets.chomp
    end_station = gets.chomp
    detect_starting_station = @all_stations.detect { |station| station.name == starting_station }
    detect_end_station = @all_stations.detect { |station| station.name == end_station }
    route = Route.new(detect_starting_station, detect_end_station)
    all_routes.push(route)
  end

  if input == 4
    puts 'Введите номер маршрута который вы хотите исправить'
    input_route_number = gets.to_i
    puts '1. Добавить станцию'
    puts '2. Удалить станцию'
    input_add_or_delete = gets.chomp
    notation
    puts 'Введите название станции'
    station_name = gets.chomp
    choosen_station = @all_stations.detect { |station| station.name == station_name }
    if input_add_or_delete == '1'
      all_routes[input_route_number - 1].add_station(choosen_station)
    else
      all_routes[input_route_number - 1].delete_station(choosen_station)
    end
  end

  if input == 5
    puts 'Введите номер поезда'
    input_train_number = gets.chomp
    puts 'Введите порядковый номер маршрута'
    input_route_number = gets.to_i

    choosen_train = all_trains.detect { |train| train.number == input_train_number }
    choosen_train.receive_train_trace_list(all_routes[input_route_number - 1].output)

  end

  if input == 6
    puts 'Введите номер поезда'
    input_train_number = gets.chomp

    choosen_train = all_trains.detect { |train| train.number == input_train_number }

    if choosen_train.is_a?(CargoTrain)
      puts 'Какой общий обьем груза?'
      total_amount = gets.chomp
      cargo_wagon = CargoWagon.new(total_amount)
      choosen_train.wagon_coupling(cargo_wagon)
    else
      puts 'Каково количество мест?'
      total_seats = gets.chomp
      passenger_wagon = PassengerWagon.new(total_seats)
      choosen_train.wagon_coupling(passenger_wagon)
    end
  end

  if input == 7
    puts 'Введите номер поезда'
    input_train_number = gets.chomp

    choosen_train = all_trains.select { |train| train.number == input_train_number }

    choosen_train.each(&:wagon_separate)
  end

  if input == 8
    puts 'Введите номер поезда'
    input_train_number = gets.chomp
    puts 'Введдите 1 и поезд переместиться на одну станцию вперед,
     введите 2 и поезд переместиться на одну станцию назад'
    forward_or_back = gets.chomp

    choosen_train = all_trains.detect { |train| train.number == input_train_number }
    if forward_or_back == '1'
      choosen_train.forward
    else
      choosen_train.back
    end
  end

  notation if input == 9

  if input == 10
    puts 'Введите название станции'
    station_name = gets.chomp

    choosen_station = @all_stations.detect { |station| station.name == station_name }

    if choosen_station.name == station_name
      trains = choosen_station.return_train
      trains.each { |train| puts train.number }
    end

  end

  if input == 11
    puts 'Введите номер поезда'
    input_train_number = gets.chomp

    choosen_train = all_trains.detect { |train| train.number == input_train_number }
    puts choosen_train
    i = 0
    choosen_train.wagon_block do |wagon|
      puts "Номер вагона #{i}, тип вагона #{wagon.type}"
      if choosen_train.is_a?(CargoTrain)
        puts "Количество занятого объема: #{wagon.current_amount},
         количество свободного обьема #{wagon.total_amount}"
      else
        puts "Количество занятых мест: #{wagon.current_seats},
         количество свободного обьема #{wagon.total_seats}"
      end
      i += 1
    end
  end

  if input == 12
    puts 'Введите название станции'
    input_station_name = gets.chomp
    choosen_station = @all_stations.detect { |station| station.name == input_station_name }
    choosen_station.train_block do |train|
      puts "Номер поезда #{train.number}, тип поезда #{train.type},
       количество вагонов #{train.wagon_count}"
    end
  end

  next unless input == 13
  puts 'Введите номер поезда'
  input_train_number = gets.chomp

  choosen_train = all_trains.detect { |train| train.number == input_train_number }
  puts 'Введите номер вагона'
  wagon_number = gets.to_i
  if choosen_train.is_a?(CargoTrain)
    puts 'На какой объем заполнить вагон? '
    current_amount = gets.to_i
    choosen_train.wagon[wagon_number - 1].filling(current_amount)
  else
    puts 'Занимается 1 место'
    choosen_train.wagon[wagon_number - 1].take_place
  end
end

# rubocop:enable Metrics/BlockLength

# validation verification
# puts '1' if station1.is_a? Route
# routes1 = Route.new('1','station3')
# train1.receive_train_trace_list(routes1)

# train1.company_name = 'Company1'
# train1.company_name = 'Company2'
# puts wagon1.company_name
# wagon1 = CargoWagon.new
# wagon1.company_name = 'Company2'
# puts wagon1.company_name

# puts Station.all

# puts Train.find('W1').class
# puts Train.find('W2323123').class

# train2 = CargoTrain.new ("W2")
# train3 = CargoTrain.new ("W2")

# puts CargoTrain.instances
# puts Station.instances

# task 8 assignments
# wagon2 = PassengerWagon.new(20)
# puts wagon2.total_seats
# wagon2.take_place
# puts wagon2.current_seats
# wagon2.take_place
# puts wagon2.current_seats
# puts wagon2.free_seats

# Cargo
# wagon3 = CargoWagon.new(40)
# wagon4 = CargoWagon.new(50)
# wagon5 = CargoWagon.new(100)
# wagon6 = CargoWagon.new(70)
# wagon7 = CargoWagon.new(80)
# puts wagon3.total_amount
# wagon3.filling(19)
# puts wagon3.current_amount
# puts wagon3.free_amount

# blocks assignments
# station1.train_block {|a| puts a}

# puts train1.wagon_count

# train1.wagon_coupling(wagon3)
# train1.wagon_coupling(wagon4)
# train1.wagon_coupling(wagon5)
# train1.wagon_coupling(wagon6)
# train1.wagon_coupling(wagon7)

# puts train1.wagon_count

# train1.wagon_block {|wagon| puts wagon}
