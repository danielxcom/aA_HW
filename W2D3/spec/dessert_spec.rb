require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "Chris") }
  let(:skittles) { Dessert.new("skittles", 213, chef) }
  describe "#initialize" do
    it "sets a type"
      expect (skittles.type)).to eq("skittles")
    end

    it "sets a quantity"
      expect(skittles.quantity).to eq(213)
    end

    it "starts ingredients as an empty array"
    expect(skittles.ingredient).to be_empty
  end

    it "raises an argument error when given a non-integer quantity"
    expect {Dessert.new ("skittles", "miami_heat", chef) }.to_raise_error(ArgumentError)
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array"
      brownie.add_ingredient("chocolate")
      expect(brownie.ingredients).to include("chocolate")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredient = ['chocolate', 'flour', 'strawberries', 'egg', 'sugar', 'butter', 'frosting']

      ingredient.each do |ingredient|

        brown.add_ingredient(ingredient)
      end

      expect (brownie.ingredient).to eq(ingredient)
      brownie.mix!

    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity"
      brownie.eat(20)
      expect(brownie.quantity).to eq(80)
    end
    it "raises an error if the amount is greater than the quantity"
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name"
    allow(chef).to receive (:titleize).and_return("Dan the Man's Plan of Banana Foods")
    expect(skittles.serve).to eq("Dan the Man")
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in"
  end
end
