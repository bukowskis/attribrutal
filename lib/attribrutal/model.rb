module Attribrutal

  module Model

    def self.included(base)
      base.extend ClassMethods
    end

    def initialize( attrs = {} )
      @attributes = attrs
    end

    def raw_attributes
      self.class.instance_variable_get("@attributes").keys.inject(Hash.new) do |attributes, attribute|
        attributes[attribute] = @attributes[attribute]
        attributes
      end
    end

    def attributes
      self.class.instance_variable_get("@attributes").keys.inject(Hash.new) do |attributes, attribute|
        attributes[attribute] = self.send(attribute)
        attributes
      end
    end

    module ClassMethods

      def attribute (sym, coercer=nil, attrs = {})

        define_method(sym) do
          if coercer
            coercer.send(:coerce, @attributes[sym], attrs[:default])
          else
            @attributes[sym] || default
          end
        end

        define_method("#{sym}=".to_sym) do |value|
          @attributes[sym] = value
        end

        if @attributes
          @attributes.merge!({ sym => coercer })
        else
          @attributes = { sym => coercer }
        end
      end

      def attributes
        @attributes
      end

    end

  end

end
