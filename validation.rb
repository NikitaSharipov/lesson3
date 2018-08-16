module Validation
  def self.included(base)
    class_variable_set :@@validations, {}
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, additional = 'Unknown')
      validations = class_variable_get :@@validations
      validations[name] ||= []
      validations[name] << { type: type, additional: additional }
    end
  end

  module InstanceMethods
    def validate!
      puts @additional
      validations = self.class.class_variable_get :@@validations
      validations.each do |name, parameters|
        parameters.each do |options|
          type = options[:type]
          additional = options[:additional]
          if type == :presence
            raise 'Значение нил' if send(name).nil?
            raise 'Пустая строка' if send(name) == ''
          elsif type == :format
            raise 'Number has invalid format' if send(name) !~ additional
          elsif type == :type
            raise 'Wrong class' if send(name).class != additional
          end
          true
        end
      end
    end

    def validate?
      validate!
    rescue RuntimeError => e
      puts e.message
      false
    end
  end
end

#   module ClassMethods
#     def validate (name, type, additional)
#       if type == :presence
#         raise "Значение нил" if name == nil
#         raise "Пустая строка" if name == ''
#       elsif type == :format
#         raise 'Number has invalid format' if name !~ additional
#       else type == :type
#         raise "Wrong class" if name.class != additional
#       end
#       true
#     end
#   end
#
#   module InstanceMethods
#     def validate!
#
#     end
#   end
#   =en d
#
#
# =begin
# module Validation
#   def validate (name, type, forma, input_class)
#     if type == :presence
#       raise "Значение нил" if name == nil
#       raise "Пустая строка" if name == ''
#     elsif type == :format
#       raise 'Number has invalid format' if name !~ forma
#     else type == :type
#       raise "Wrong class" if name.class != input_class
#     end
#     true
#   end
# end
#
