
class Route
def initialize(starting_station, end_station)
    @train_trace_list = [starting_station, end_station]
  end

  def add_station (intermediate_station)
    @train_trace_list.insert(-2, intermediate_station)
  end

  def delete_station(intermediate_station)
    @train_trace_list.delete(intermediate_station)
  end

  def output
    @train_trace_list.each { |station| puts station.name }
    @train_trace_list
  end

end

class Train
  attr_accessor :speed
  attr_reader :wagon_count, :number, :type
  def initialize(number, type, wagon_count)
    @number = number
    @type = type
    @wagon_count = wagon_count  
    @speed = 0  
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
    @current = 0
  end
   
  def forward
    @current += 1 
  end

  def back
    @current -= 1  
  end
  
  def return_stations
    puts "Предыдущая станция называется #{@train_trace_list[@current-1]}, текущая станция : #{@train_trace_list[@current]}, следующая станция #{@train_trace_list[@current+1]}"
    end
end

class Station  

  attr_reader :name
  
  def initialize (name)
  @name = name
  @trains = []
  end

  def train_reception(train)
    @trains.push(train)
  end

  def return_train
    @trains
  end

  def return_type 
     cargo = 0
     @trains.each do |train|
       cargo += 1 if train.type == "грузовой"
     end
     puts "Грузовых поездов на станции: #{cargo}. Пассажирских поездов на станции: #{@trains.length - cargo}."
  end

  def delete_train (number)
    @trains.delete(number)
  end

  
end


#Проверки класса Роут
station2 = Station.new ("Station A")
station3 = Station.new ("Station E")
station4 = Station.new ("Station B")
station5 = Station.new ("Station C")
rout1 = Route.new(station2,station3)
rout1.add_station(station4)
rout1.add_station(station5)
rout1.delete_station(station4)

rout1.output

#Проверки класса Траин
train1 = Train.new("W1", "грузовой", 5)
train2 = Train.new("Q2", "пассажирский", 5)
train3 = Train.new("M3", "грузовой", 6)

#train1.wagon_coupling
#train1.wagon_split
#train1.receive_train_trace_list(rout1.output)
#train1.forward
#train1.forward
#train1.back
#train1.return_stations

station1 = Station.new ("Station A")
#station1.train_reception(train1)
#station1.train_reception(train2)
#station1.train_reception(train3)
#station1.return_train
#station1.return_type
#station1.train_reception("Q1","пассажирский")
#station1.train_reception("P1","грузовой")

#station1.return_train
#station1.return_type
#station1.delete_train("W1")
#station1.return_train


