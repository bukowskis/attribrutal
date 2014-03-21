module Attribrutal

  module Model

    def self.included(base)
      base.extend ClassMethods
    end

    def initialize( attrs = {} )
      all_attributes         = attrs.symbolize_keys
      @raw_attributes        = all_attributes.select {|k,v| attribute_keys.include? k }
      other_attributes       = all_attributes.reject {|k,v| attribute_keys.include? k }
      other_attributes.map {|key, val| self.send("#{key}=", val) if respond_to?("#{key}=") }
    end

    def raw_attributes
      @raw_attributes || {}
    end

    def attributes
      attribute_keys.inject(Hash.new) do |attributes, attribute|
        attributes[attribute] = self.send(attribute)
        attributes
      end
    end

    def read_attribute(name)
       given_default = self.class.default_value_for(name)
       default_value = case given_default.class.name
                       when "NilClass", "TrueClass", "FalseClass", "Numeric", "Fixnum", "Symbol"
                         given_default
                       when "Proc"
                         given_default.call
                       else
                         given_default.clone
                       end
      coercer = self.class.coercer_for(name)
      if coercer && coercer.respond_to?(:coerce)
        coercer.coerce raw_attributes[name], default_value
      else
        raw_attributes[name] ||= default_value
      end
    end

    def attribute_keys
      self.class.attribute_keys || {}
    end

    module ClassMethods

      def attribute (sym, coercer=nil, attrs = {})


        if coercer == Attribrutal::Type::Boolean
          define_method "#{sym}?" do
            send(sym)
          end
        end

        define_method sym do
          read_attribute(sym)
        end

        define_method "#{sym}=".to_sym do |value|
          raw_attributes[sym] = value
        end

        if @attributes
          @attributes.merge!({ sym => [coercer, attrs] })
        else
          @attributes = { sym => [coercer, attrs] }
        end
      end

      def attributes
        if superclass.respond_to? :attributes
          superclass.attributes.merge(@attributes)
        else
          @attributes
        end
      end

      def coercer_for(name)
        @attributes[name].first
      end

      def default_value_for(name)
        @attributes[name].last[:default]
      end

      def attribute_keys
        if superclass.respond_to? :attribute_keys
          superclass.attribute_keys + @attributes.keys
        else
          @attributes.keys
        end
      end

    end

  end

end
