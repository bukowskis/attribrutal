module Coercer
  class Baz
    def self.coerce(arg, default = nil)
      if arg.nil?
        default
      else
        ::Baz.new(arg)
      end
    end
  end
end
