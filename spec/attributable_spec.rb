require "spec_helper"

describe "Attributable#attributes" do
  it "should record defined attributes" do
    Bar.attributes.keys.should == [:foo, :bar, :baz]
  end
end
