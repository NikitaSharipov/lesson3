class PassengerWagon < Wagon 

  attr_accessor :total_seats
  attr_accessor :current_seats

  def initialize (total_seats)
    super(type)
    @type = 'пассажирский'
    @total_seats = total_seats
    @current_seats = 0
  end

  def take_place
    @current_seats += 1
  end

  def free_seats
    @total_seats - @current_seats
  end

end
