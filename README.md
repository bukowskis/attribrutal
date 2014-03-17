Attributable
============

Lazily coerced attributes

##Usage:

    class MoreSpeed
      include Attributable::Model
      attribute :harder
      attribute :better
      attribute :faster
      attribute :stronger
    end

##With coercion:

    class MoreSpeed
      include Attributable::Model
      attribute :harder, Coercion::Integer
      attribute :better, Coercion::String
      attribute :faster, Coercion::Boolean
      attribute :stronger, MyAwesomeCoercion
    end

##With defaults:

    class MoreSpeed
      include Attributable::Model
      attribute :harder, Coercion::Integer, default: 10
      attribute :better, Coercion::String, default: "better"
      attribute :faster, Coercion::Boolean, default: true
      attribute :stronger, MyAwesomeCoercion
    end

##Introspection

`MoreSpeed.attributes` return a hash of attribute names and their types

##Assignment

`MoreSpeed.new harder: 30, better: "much"`

##Getting at raw (uncoerced) attributes

`MoreSpeed.new.raw_attributes`

##Getting at coerced attributes

`MoreSpeed.new.attributes`

##Coercers

Implement your own, they should provide a class method `coerce` which
takes two arguments; a value and a default and return the value
coerced or the default, its all up to the coercer. You can implement
any kind of additional meta information on the type.
