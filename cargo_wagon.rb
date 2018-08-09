class CargoWagon < Wagon 

  attr_accessor :total_amount
  attr_accessor :current_amount

  def initialize (total_amount)
    super(type)
    @type = 'грузовой'
    @total_amount = total_amount
    @current_amount = 0
  end

  def filling (amount)
    @current_amount += amount
  end

  def free_amount
    @total_amount - @current_amount
  end

end
