class CargoWagon < Wagon 
  def initialize
    super(type)
    @type = 'грузовой'
  end
end
