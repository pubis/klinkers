require 'spec_helper'

describe Portfolio do
  it "should not use Account's model_name" do
    Portfolio.model_name.should eq("Portfolio")
  end
end
