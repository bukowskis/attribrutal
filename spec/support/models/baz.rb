class Baz
  include Attribrutal::Model
  attribute :alpha, Attribrutal::Type::Integer, default: 1
  attribute :beta, Attribrutal::Type::Integer, default: 2
end
