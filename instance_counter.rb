module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :inst

    def instances
      @inst ||= 0
      @inst
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.inst ||= 0
      self.class.inst += 1
    end
  end
end
