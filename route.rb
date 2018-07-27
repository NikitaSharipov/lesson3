class Route

  #все эти методы используются извне
  public

  def initialize(starting_station, end_station)
    @train_trace_list = [starting_station, end_station]
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