class Bar
  include Attributable::Model
  attribute :foo, Coercer::Boolean
  attribute :bar, Coercer::String, default: "bar"
  attribute :baz, Coercer::Baz, default: lambda { ::Baz.new alpha: 50, beta: 100 }
end
