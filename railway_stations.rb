
class Rout
  def initialize(starting_station = "Station A", end_station = "Station F")
    @starting_station = starting_station
    @end_station = end_station
    @@train_trace_list = {}
    create_hash
  end

  @@list_of_stations = {"Station A" => 1, "Station B" => 2, "Station C" => 3, "Station D" => 4, "Station E" => 5, "Station F" => 6}  

  def create_hash
    #добавляем в хэш маршрута первую станцию и приравниваем ей порядковый номер из хэша станций
   @@train_trace_list[@starting_station] = @@list_of_stations[@starting_station]
   @@train_trace_list[@end_station] = @@list_of_stations[@end_station] 
  end

  def add_station (intermediate_station)
   @@train_trace_list[intermediate_station] = @@list_of_stations[intermediate_station]
  end

  def delete_station(intermediate_station)
    @@train_trace_list.delete(intermediate_station)
  end

  def output
   l =  @@train_trace_list.sort_by { |key, value| value }
  end

end

class Train
  attr_accessor :speed
  attr_reader :wagon_count, :number, :type
  def initialize(number, type, wagon_count,speed = 0)
    @number = number
    @type = type
    @wagon_count = wagon_count  
    @speed = speed  
  end

  def stop
  self.speed = 0
  end

  def wagon_coupling
   if @speed == 0 
    @wagon_count += 1
    puts "Вагон прицепили, теперь количество вагонов #{@wagon_count}"
   else
    puts "Нельзя прицепить вагон, поезд движется!"
   end
  end

  def wagon_split
    if @speed == 0
      @wagon_count -= 1
      puts "Вагон отцепили, теперь количество вагонов #{@wagon_count}"
    else
      puts "Нельзя отцепить вагон, поезд движется!"
    end
  end

  def receive_train_trace_list (a)
    @train_trace_list = a
    @current = @train_trace_list[0][1]
  end
   
  def forward
    i = 0
    while i < @train_trace_list.length  do     
      if @current == @train_trace_list[i][1]
        @current = @train_trace_list[i+1][1]
        break
      end
    i += 1
    end    
    puts "Текущая станция номер #{@current}"
  end
  def back
    i = 0
    while i < @train_trace_list.length  do
      if @current == @train_trace_list[i][1]
        @current = @train_trace_list[i-1][1]
        break
      end
    i += 1
    end 
  end
  
  def return_stations
    i=0
    while i < @train_trace_list.length do
      if @current == @train_trace_list[i][1]
      break
      end
      i += 1
    end
    puts "Предыдущая станция называется #{@train_trace_list[i-1][0]}, текущая станция : #{@train_trace_list[i][0]}, следующая станция #{@train_trace_list[i+1][0]}"
    end
end

class Station  
  
  def initialize (name)
  @name = name
  @trains = {}
  end

  def train_reception( number, type)
    @trains[number] = type
  end

  def return_train
    @trains.each do |key , value|
    puts key
    end
  end

  def return_type
    type_cargo = 0
    type_passenger = 0
    @trains.each do |key,value|
    if value == "грузовой"
      type_cargo += 1
    else
      type_passenger += 1
    end
    end
    puts "Грузовых поездов: #{type_cargo} пассажирских поездов :#{type_passenger}"
  end
  def delete_train (number)
    @trains.delete(number)
  end

  
end


#Проверки класса Роут
rout1 = Rout.new("Station A","Station E")
rout1.add_station("Station B")
rout1.add_station("Station C")
rout1.delete_station("Station B")
rout1.output

#Проверки класса Траин
train1 = Train.new("W1","грузовой",5)

#train1.wagon_coupling
#train1.wagon_split
#train1.receive_train_trace_list(rout1.output)
#train1.forward
#train1.forward
#train1.back
#train1.return_stations

station1 = Station.new ("Station A")
station1.train_reception("W1","грузовой")
station1.train_reception("Q1","пассажирский")
station1.train_reception("P1","грузовой")

station1.return_train
station1.return_type
station1.delete_train("W1")
station1.return_train

