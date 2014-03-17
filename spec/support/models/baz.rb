class Baz
  include Attributable::Model
  attribute :alpha, Coercer::Integer, default: 1
  attribute :beta, Coercer::Integer, default: 2
end
