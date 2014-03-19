module Attribrutal
  module Type

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

    class Array

      def initialize(subtype)
        @subtype = subtype
      end

      def coerce(arg, default = nil)
        return default unless arg
        arg.collect {|member| @subtype.coerce(member) }
      end

      def self.[] (subtype)
        new(subtype)
      end
    end

  end
end
