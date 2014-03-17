module Coercer
  class Boolean
    def self.coerce(arg, default = nil)
      if arg == true
        true
      else
        false
      end
    end
  end
  class Integer
    def self.coerce(arg, default = nil)
      if arg.nil?
        default
      else
        Integer(arg)
      end
    end
  end
  class String
    def self.coerce(arg, default = nil)
      if arg.nil?
        default
      else
        String(arg)
      end
    end
  end
  # class Baz
  #   def self.coerce(arg, default = nil)
  #     if arg.nil?
  #       default
  #     else
  #       ::Baz.new(arg)
  #     end
  #   end
  # end
end
