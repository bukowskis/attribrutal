require "spec_helper"

describe "Attributable#attributes" do

  let (:bar) { Bar.new foo: nil, bar: 10, baz: { alpha: 10, beta: "20" } }

  it "should record defined attributes" do
    Bar.attributes.keys.should == [:foo, :bar, :baz]
  end

  it "should record defined attribute types" do
    Bar.attributes.values.should == [Coercer::Boolean, Coercer::String, Coercer::Baz]
  end

  it "should support mass assignment" do
    bar.raw_attributes.values.should == [nil, 10, { alpha: 10, beta: "20" }]
  end

  it "should perform coercion" do
    attributes = bar.attributes
    attributes[:foo].should == false
    attributes[:bar].should == "10"
  end

  it "should support recursive coercion" do
    attributes = bar.attributes
    attributes[:baz].alpha.should == 10
    attributes[:baz].beta.should == 20
  end

end
