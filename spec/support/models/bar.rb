class Bar
  include Attributable::Model
  attribute :foo, Coercer::Boolean
  attribute :bar, Coercer::String, default: "baz"
  attribute :baz, Coercer::Baz, default: ::Baz.new
end
