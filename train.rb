class Train
  attr_accessor :speed
  attr_reader :number, :type
  
  
  public

  def initialize(number, type)
    @type = type
    @number = number
    @speed = 0  
    @wagon = []
  end

  def stop
    self.speed = 0
  end

  def receive_train_trace_list(a)
    @train_trace_list = a
    @current = 0
    @train_trace_list[@current].train_reception(self)
  end
   
  def forward 
    @train_trace_list[@current].delete_train(self)
    @current += 1 
    @train_trace_list[@current].train_reception(self)
  end

  def back
    @train_trace_list[@current].delete_train(self)
    @current -= 1  
    @train_trace_list[@current].train_reception(self)
  end
  
  def return_stations
    puts "Предыдущая станция называется #{@train_trace_list[@current - 1].name}, текущая станция : #{@train_trace_list[@current].name}, следующая станция #{@train_trace_list[@current + 1].name}"
  end

  def wagon_coupling (single_wagon)
    @wagon.push(single_wagon) if single_wagon.type == @type
  end

  def wagon_separate
    @wagon.delete_at(-1)
  end

  def wagon_count
    @wagon.length
  end

  #вынесен в приват потому что эта проверка необходима только в этом классе
  private

  def stop?
     @speed.zero?
  end  
end
