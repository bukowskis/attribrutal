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
      @raw_attributes
    end

    def attributes
      attribute_keys.inject(Hash.new) do |attributes, attribute|
        attributes[attribute] = self.send(attribute)
        attributes
      end
    end

    def attribute_keys
      self.class.attribute_keys
    end

    module ClassMethods

      def attribute (sym, coercer=nil, attrs = {})

        define_method(sym) do
          if coercer && coercer.respond_to?(:coerce)
            coercer.send(:coerce, raw_attributes[sym], attrs[:default])
          else
            raw_attributes[sym] ||= attrs[:default]
          end
        end

        define_method("#{sym}=".to_sym) do |value|
          raw_attributes[sym] = value
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

      def attribute_keys
        @attributes.keys
      end

    end

  end

end
