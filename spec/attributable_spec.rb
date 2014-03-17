class Baz
  include Attributable
  attribute :alpha, Coercer::Integer, default: 1
  attribute :beta, Coercer::Integer, default: 2
end

class Bar
  include Attributable
  attribute :foo, Coercer::Boolean
  attribute :bar, Coercer::String, default: "baz"
  attribute :baz, Coercer::Baz, default: ::Baz.new
end
