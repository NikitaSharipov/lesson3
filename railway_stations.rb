require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

#Проверки класса Роут
station2 = Station.new("Station A")
station3 = Station.new("Station E")
station4 = Station.new("Station B")
station5 = Station.new("Station C")
rout1 = Route.new(station2,station3)
rout1.add_station(station4)
rout1.add_station(station5)
rout1.delete_station(station4)

#rout1.output.each {|a| puts a.name}

#Проверки класса Траин

#cargotrain3 = CargoTrain.new("Z2", "грузовой", 6)
cargotrain1 = CargoTrain.new("W1")
cargotrain2 = CargoTrain.new("Q2")
cargotrain3 = CargoTrain.new("M3")

passengertrain1 = PassengerTrain.new("L4")

cargotrain1.receive_train_trace_list(rout1.output)
cargotrain1.forward
cargotrain1.forward
cargotrain1.back
cargotrain1.return_stations

#station1 = Station.new("Station A")
#station1.train_reception(cargotrain1)
#station1.train_reception(cargotrain2)
#station1.train_reception(cargotrain3)
#station1.return_train
#station1.return_type

#station1.train_reception("Q1","пассажирский")
#station1.train_reception("P1","грузовой")

#station1.return_train
#station1.return_type
#station1.delete_train("W1")
#station1.return_train

wagon1 = CargoWagon.new
wagon1.type

wagon2 = CargoWagon.new
wagon2.type

puts cargotrain1.wagon_count

cargotrain1.wagon_coupling(wagon1)

puts cargotrain1.wagon_count

cargotrain1.wagon_coupling(wagon2)

puts cargotrain1.wagon_count

cargotrain1.wagon_separate

puts cargotrain1.wagon_count