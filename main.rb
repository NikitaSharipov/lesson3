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
  puts "Список существующих станций:"
  @all_stations.each {|station| puts station.name}
end

=begin
=end

station1 = Station.new('www')
station2 = Station.new('eee')
station3 = Station.new('zzz')

@all_stations.push(station1)
@all_stations.push(station2)
@all_stations.push(station3)

routes1 = Route.new(station1,station3)
all_routes.push(routes1)

routes1.add_station(station2)

train1 = CargoTrain.new ("W1")
all_trains.push(train1)

train1.receive_train_trace_list(routes1.output)

#=end

loop do
  puts "1. Создать станцию"
  puts "2. Создать поезд"
  puts "3. Создать маршрут"
  puts "4. Управление маршрутами"
  puts "5. Назначить маршрут поезду"
  puts "6. Добавить вагон к поезду"
  puts "7. Отцепить вагон от поезда"
  puts "8. Переместить поезд по маршруту"
  puts "9. Просмотреть список станций"
  puts "10. Просмотреть список поездов на станции"
  puts "0. Выход"
  puts "Выберите вариант: "
  input = gets.to_i
  break if input == 0

  if input == 1
    puts "Введите название станции"
    station_name = gets.chomp
    station = Station.new(station_name)
    @all_stations.push(station)
  end

  if input == 2
    puts "Введите номер поезда"
    train_number = gets.chomp
    puts "1. Поезд грузовой"
    puts "2. Поезд пассажирский"
    input_train = gets.chomp
    if input_train == '1'
      train = CargoTrain.new(train_number)
    else
      train = PassengerTrain.new(train_number)
    end
    all_trains.push(train)
  end

  if input == 3
  	puts "Чтобы создать маршрут необходимо указать начальную и конечную станцию !"
    notation
    puts "Введите поочередно название начальной и конечной станции маршрута"
    input_starting_station = gets.chomp
    input_end_station = gets.chomp
    select_starting_station = @all_stations.select {|station| station.name == input_starting_station}
    select_end_station = @all_stations.select {|station| station.name == input_end_station}
    route = Route.new( select_starting_station, select_end_station)
    all_routes.push(route)
  end
  
  if input == 4
  	puts "Введите номер маршрута который вы хотите исправить"
  	input_route_number = gets.to_i
  	puts "1. Добавить станцию"
  	puts "2. Удалить станцию"
  	input_add_or_delete = gets.chomp
  	notation
  	puts "Введите название станции"
  	station_name = gets.chomp
  	if input_add_or_delete == '1' 
  	  @all_stations.each do |station| 
	    if station.name == station_name
	      all_routes[input_route_number - 1].add_station(station)
	      #all_routes[input_route_number - 1].output.each {|a| puts a.name}
	    end
	  end
	else
	  @all_stations.each do |station| 
	    if station.name == station_name
	      all_routes[input_route_number - 1].delete_station(station)
	      #all_routes[input_route_number - 1].output.each {|a| puts a.name}
	    end
	  end
	end
  end
  
  if input == 5
    puts "Введите номер поезда"
    input_train_number = gets.chomp
    puts "Введите порядковый номер маршрута"
    input_route_number = gets.to_i
    all_trains.each do |train|
      if train.number == input_train_number
      	train.receive_train_trace_list(all_routes[input_route_number - 1].output)
      end
    end
  end
  
  if input == 6
    puts "Введите номер поезда"
    input_train_number = gets.chomp
    all_trains.each do |train|
      if train.number == input_train_number
        if train.type == 'грузовой'
          cargo_wagon = CargoWagon.new
          train.wagon_coupling(cargo_wagon)
        else
          passenger_wagon = PassengerWagon.new
          train.wagon_coupling(passenger_wagon)
        end
      end
    end
  end

  if input == 7
    puts "Введите номер поезда"
    input_train_number = gets.chomp

    all_trains.each do |train|
      if train.number == input_train_number
        train.wagon_separate
      end 
    end
  end
  
  if input == 8
    puts "Введите номер поезда"
    input_train_number = gets.chomp
    puts "Введдите 1 и поезд переместиться на одну станцию вперед, введите 2 и поезд переместиться на одну станцию назад"
    forward_or_back = gets.chomp
      all_trains.each do |train|
        if train.number == input_train_number
          if forward_or_back == '1'
            train.forward
          else
          	train.back
          end
        end
      end
  end

  if input == 9
    notation
  end

  if input == 10
    puts "Введите название станции"
    station_name = gets.chomp
    @all_stations.each do |station|
      if station.name == station_name
        trains = station.return_train
        #trains.each {|train| puts train.class}
        trains.each {|train| puts train.number}
      end
    end
  end

end


#puts train1.return_stations

=begin
  def notation
    puts "Чтобы создать маршрут необходимо указать начальную и конечную станцию !"
    puts "Список существующих станций:"
    @all_stations.each {|station| puts station.name}
  end
=end