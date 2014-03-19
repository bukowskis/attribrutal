class Bar
  include Attribrutal::Model
  attribute :foo, Attribrutal::Type::Boolean
  attribute :bar, Attribrutal::Type::String, default: "bar"
  attribute :baz, Coercer::Baz, default: lambda { ::Baz.new alpha: 50, beta: 100 }
end
