class PassengerTrain < Train
  def initialize(number)
    super(number, type)
    @type = 'пассажирский'
  end
end
