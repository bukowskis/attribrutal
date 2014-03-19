class TypedCollections
  include Attribrutal::Model

  attribute :strings,  Attribrutal::Type::Array[Attribrutal::Type::String], default: ["larry", "curly", "moe"]
  attribute :integers, Attribrutal::Type::Array[Attribrutal::Type::Integer], default: [42, 42, 42]

end
