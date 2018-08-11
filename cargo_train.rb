class CargoTrain < Train
  def initialize(number)
    super(number, type)
    @type = 'грузовой'
  end
end
