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
station1 = Station.new('www')
station2 = Station.new('eee')
station3 = Station.new('zzz')

@all_stations.push(station1)
@all_stations.push(station2)
@all_stations.push(station3)

routes1 = Route.new(station1,station3)
all_routes.push(routes1)

routes1.add_station(station2)

train1 = CargoTrain.new ("WW1-22")
all_trains.push(train1)

train1.receive_train_trace_list(routes1.output)
=end

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
    begin
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
    puts "Поезд #{train.number} создан, тип поезда #{train.type}"
    rescue RuntimeError => e
      puts "Что-то пошло не так, повторите ввод. Ошибка: #{e.inspect}"
      retry
    end
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
    
    choosen_station = @all_stations.select {|station| station.name == station_name }

  	if input_add_or_delete == '1' 
 	  choosen_station.each do |station|
        all_routes[input_route_number - 1].add_station(station)
      end
	else
      choosen_station.each do |station|
        all_routes[input_route_number - 1].delete_station(station)
      end
	end
  end
  
  if input == 5
    puts "Введите номер поезда"
    input_train_number = gets.chomp
    puts "Введите порядковый номер маршрута"
    input_route_number = gets.to_i

    choosen_train = all_trains.select {|train| train.number == input_train_number }

    choosen_train.each do |train| 
      train.receive_train_trace_list(all_routes[input_route_number - 1].output) 
    end
  end
  
  if input == 6
    puts "Введите номер поезда"
    input_train_number = gets.chomp

    choosen_train = all_trains.select {|train| train.number == input_train_number }

    choosen_train.each do |train|
      if train.is_a?(CargoTrain)
        cargo_wagon = CargoWagon.new
        train.wagon_coupling(cargo_wagon)
      else
        passenger_wagon = PassengerWagon.new
        train.wagon_coupling(passenger_wagon)
      end
    end
  end

  if input == 7
    puts "Введите номер поезда"
    input_train_number = gets.chomp
    
    choosen_train = all_trains.select {|train| train.number == input_train_number }

    choosen_train.each do |train|
        train.wagon_separate 
    end
  end
  
  if input == 8
    puts "Введите номер поезда"
    input_train_number = gets.chomp
    puts "Введдите 1 и поезд переместиться на одну станцию вперед, введите 2 и поезд переместиться на одну станцию назад"
    forward_or_back = gets.chomp

    choosen_train = all_trains.select {|train| train.number == input_train_number }

    choosen_train.each do |train|
      if forward_or_back == '1'
        train.forward
      else
        train.back
      end  
    end
  end

  if input == 9
    notation
  end

  if input == 10
    puts "Введите название станции"
    station_name = gets.chomp

    choosen_station = @all_stations.select {|station| station.name == station_name }

    choosen_station.each do |station|
      if station.name == station_name
        trains = station.return_train
        trains.each {|train| puts train.number}
      end
    end
  end

end

def l
  a = [1,2,3,4,5]
  return a.each {|a| a}
end

#Проверки валидностей
#puts '1' if station1.is_a? Route
#routes1 = Route.new('1','station3')
#train1.receive_train_trace_list(routes1)


#train1.company_name = 'Company1'
#train1.company_name = 'Company2'
#puts wagon1.company_name
#wagon1 = CargoWagon.new
#wagon1.company_name = 'Company2'
#puts wagon1.company_name

#puts Station.all

#puts Train.find('W1').class
#puts Train.find('W2323123').class

#train2 = CargoTrain.new ("W2")
#train3 = CargoTrain.new ("W2")

#puts CargoTrain.instances
#puts Station.instances
