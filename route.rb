require_relative 'instance_counter.rb'

class Route

  #все эти методы используются извне
  include InstanceCounter

  def initialize(starting_station, end_station)
    @train_trace_list = [starting_station, end_station]
    register_instance
  end

  def add_station(intermediate_station)
    @train_trace_list.insert(-2, intermediate_station)
  end

  def delete_station(intermediate_station)
    @train_trace_list.delete(intermediate_station)
  end

  def output
    @train_trace_list
  end

end