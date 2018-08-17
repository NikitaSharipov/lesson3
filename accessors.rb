module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_accessor_whith_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          history_variable = "@#{name}_history"
          value_array = instance_variable_get(history_variable) || []
          value_array << value
          instance_variable_set(history_variable, value_array)
        end
        define_method("#{name}_history") { instance_variable_get("@#{name}_history") }
      end
    end

    def strong_attr_accessor(name, input_class)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise 'Diferent class' if value.class != input_class
        instance_variable_set(var_name, value)
      end
    end
  end

  # strong_attr_accessor
  # if value.class == input_class

  module InstanceMethods
    def instances
      @inst
      #      self.class.inst ||= {}
      #      self.class.inst
    end
  end
end

#
#           @inst ||= {}
#           value_array = @inst[var_name] || []
#           value_array << value
#           @inst[var_name] = value_array
#           history_variable = "@#{name}_history"
#           instance_variable_set(history_variable, @inst[var_name])
#
