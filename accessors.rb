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
          @inst ||= {}
          a = @inst[var_name]
          a ||= []
          a.push(value)
          @inst[var_name] = a
        end
        define_method("#{name}_history") { @inst[var_name] }
      end
    end

    def strong_attr_accessor(name, input_class)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise 'Diferent class' if value.class != input_class
        instance_variable_set(var_name, value) if value.class == input_class
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
