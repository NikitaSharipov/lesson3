require_relative 'instance_counter.rb'

class Route

  #все эти методы используются извне
  include InstanceCounter

  def initialize(starting_station, end_station)
    @train_trace_list = [starting_station, end_station]
    register_instance
    validate!
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

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    perm = true
    @train_trace_list.each {|station| perm = false unless station.is_a? Station}
    raise "each station must be Station Object" if perm == false
    true
  end

end
