require_relative 'company_name'
require_relative 'instance_counter.rb'
require_relative 'accessors.rb'
require_relative 'validation.rb'

class Train
  include CompanyName
  include InstanceCounter
  include Accessors
  include Validation
  attr_accessor :speed, :wagon, :number
  attr_reader :type

  attr_accessor_whith_history :wagon_color, :wagon_material

  strong_attr_accessor(:wagon_old, Integer)

  @@all_trains = []

  TRAIN_NUMBER_FORMAT = /^[\da-zA-zа-яА-я]{3}-?[\da-zA-zа-яА-я]{2}$/

  validate :number, :presence
  validate :speed, :presence
  validate :wagon, :presence

  validate(:number, :format, TRAIN_NUMBER_FORMAT)

  validate :number, :type, String

  def initialize(number, type)
    #    validate!(number)
    @type = type
    @number = number
    @speed = 0
    @wagon = []
    @@all_trains.push(self)
    register_instance
    #    self.class.validate(number, :type, Fixnum )
  end

  def self.find(get_number)
    @@all_trains.detect { |train| train.number == get_number }
  end

  def stop
    self.speed = 0
  end

  def receive_train_trace_list(trace_list)
    validate_route(trace_list)
    @train_trace_list = trace_list
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
    [@train_trace_list[@current - 1].name, @train_trace_list[@current].name,
     @train_trace_list[@current + 1].name]
  end

  def wagon_coupling(single_wagon)
    @wagon.push(single_wagon) if single_wagon.type == @type
  end

  def wagon_separate
    @wagon.delete_at(-1)
  end

  def wagon_count
    @wagon.length
  end

  def valid?
    validate!
    validate_route(@train_trace_list)
  rescue StandardError
    false
  end

  def wagon_block
    @wagon.each { |wagon| yield(wagon) }
  end

  # protected

  #  def validate!(number)
  #    raise 'number too short' if number.length < 2
  #    raise 'number too long' if number.length > 20
  #    raise 'Number has invalid format' if number !~ TRAIN_NUMBER_FORMAT
  #    true
  #  end
  #
  #  def validate_route(route)
  #    raise 'train trace list must be Array' unless route.is_a? Array
  #  end

  private

  def stop?
    @speed.zero?
  end
end
