require_relative 'instance_counter.rb'

class Station  

  include InstanceCounter
  attr_reader :name

  STATION_NAME_FORMAT = /^[a-zA-zа-яА-я]{2,20}$/
  
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations.push(self)
    register_instance
    validate!
  end

  def self.all
    @@all_stations
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
    return cargo, @trains.length - cargo
  end

  def delete_train(number)
    @trains.delete(number)
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "name too short" if @name.length < 2
    raise "name too long" if @name.length > 20
    raise "Too long or too short station name" if @name !~ STATION_NAME_FORMAT
    true
  end

  
end
