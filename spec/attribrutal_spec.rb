require "spec_helper"

describe "Attribrutal#attributes" do

  let (:bar)                            { Bar.new foo: nil, bar: 10, baz: { alpha: 10, beta: "20" } }
  let (:bar_with_defaults)              { Bar.new }
  let (:typed_collections)               { TypedCollections.new integers: ["1","2","3"], strings: [true, 10, 1.0] }
  let (:typed_collections_with_defaults) { TypedCollections.new }
  let (:uncoercable) { Uncoercable.new not: "let through", coercable: "no touch" }
  let (:barn) { Barn.new }

  it "records defined attributes" do
    Bar.attributes.keys.should == [:foo, :bar, :baz]
  end

  it "records defined attribute types" do
    Bar.attribute_keys.should == [ :foo, :bar, :baz ]
    Bar.attributes.values.should == [Attribrutal::Type::Boolean, Attribrutal::Type::String, Coercer::Baz]
  end

  it "supports mass assignment" do
    bar.raw_attributes.values.should == [nil, 10, { alpha: 10, beta: "20" }]
    bar.attributes[:foo].should == false
    bar.attributes[:bar].should == "10"
    bar.attributes[:baz].alpha.should == 10
    bar.attributes[:baz].beta.should == 20
  end

  it "performs coercion" do
    attributes = bar.attributes
    attributes[:foo].should == false
    attributes[:bar].should == "10"
  end

  it "supports recursive coercion" do
    attributes = bar.attributes
    attributes[:baz].alpha.should == 10
    attributes[:baz].beta.should == 20
  end

  it "supports array of type coercion" do
    typed_collections.integers.should == [1, 2 ,3]
    typed_collections.strings.should == ["true", "10", "1.0"]
    typed_collections_with_defaults.integers.should == [42, 42, 42]
    typed_collections_with_defaults.strings.should == ['larry', 'curly', 'moe']
  end

  it "supports defaults" do
    bar_with_defaults.bar.should == "bar"
    bar_with_defaults.baz.class.should == Baz
    bar_with_defaults.baz.alpha.should == 50
    bar_with_defaults.baz.beta.should == 100
  end

  it "defines symbol? if boolean" do
    bar.foo?.should == false
  end

  it "passes types through without coercion if type doesn't respond to coerce" do
    uncoercable.not.should == "let through"
    uncoercable.coercable.should == "no touch"
  end

  it "supports inheritance" do
    Barn.attribute_keys.should == [ :foo, :bar, :baz, :diaper_cost ]
    Barn.attributes.values.should == [ Attribrutal::Type::Boolean, Attribrutal::Type::String, Coercer::Baz, Attribrutal::Type::Integer ]
  end

  it "is fast enough" do
    initialization_time = 1000 * Benchmark.realtime do
      1000.times { Bar.new }
    end
    initialization_time.should < 5

    coercion_time = 1000 * Benchmark.realtime do
      1000.times { Bar.new(foo: nil, bar: 10, baz: { alpha: "1", beta: "2" }).attributes }
    end
    coercion_time.should < 25
  end

end
