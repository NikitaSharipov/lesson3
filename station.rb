require_relative 'instance_counter.rb'

class Station  

  include InstanceCounter
  attr_reader :name
  
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations.push(self)
    register_instance
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

  
end