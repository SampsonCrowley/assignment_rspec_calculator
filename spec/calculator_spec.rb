require_relative 'spec_helper'
require_relative '../lib/calculator'

describe "Calculator" do 

  describe "#initialize" do 
    it "should start with empty memory" do 
      expect(Calculator.new.memory).to be_nil
    end

    it "should take an argument for stringifying results" do 
      calculator = Calculator.new(true)
      expect(calculator.instance_variable_get(:@stringify)).to be true
    end
  end

  context "operations" do 

    let(:calculator){Calculator.new}
    
    describe "#add" do 
      it "should add two numbers" do 
        expect(calculator.add(1,1)).to eq(2)
      end

      it "should return the correct sum" do 
        expect(calculator.add(1,2)).not_to eq(4)
      end
    end

    describe "#subtract" do 
      it "should subtract the second number from the first" do 
        expect(calculator.subtract(2,1)).to eq(1)
      end

      it "should return the correct difference" do 
        expect(calculator.subtract(4,1)).not_to eq(2)
      end
    end

    describe "#multiply" do 
      it "should correctly multiply two integers" do 
        expect(calculator.multiply(1,1)).to eq(1)
        expect(calculator.multiply(1,2)).to eq(2)
      end

      it "should correctly multiply two floats" do 
        expect(calculator.multiply(1.5, 2.5)).to eq(3.75)
        expect(calculator.multiply(5.5, 10)).to eq(55)
        expect(calculator.multiply(3.4125, 3.4125)).to be_within(0.00001).of (11.645_156_25)
      end

      it "should return zero for any number times zero" do 
        expect(calculator.multiply(0,rand(11))).to eq(0)
        expect(calculator.multiply(0,rand(11))).to eq(0)
        expect(calculator.multiply(0,5.5)).to eq(0.0)
      end

      it "should return a negative number if one number is negative" do 
        expect(calculator.multiply(-1,3)).to eq(-3)
        expect(calculator.multiply(-5,5)).to eq(-25)
        expect(calculator.multiply(-10,2)).to eq(-20)
        expect(calculator.multiply(-5.5, 10)).to eq(-55)
      end

      it "should return a postive number if both numbers are negative" do 
        expect(calculator.multiply(-1, -1)).to eq(1)
        expect(calculator.multiply(-1.5, -2.5)).to eq(3.75)
        expect(calculator.multiply(-5.5, -10)).to eq(55)
        expect(calculator.multiply(-3.4125, -3.4125)).to be_within(0.00001).of(11.645_156_25)
      end
    end

    describe "#divide" do 

      it "should properly divide two floats" do 
        expect(calculator.divide(5.0, 2.0)).to eq(2.5)
        expect(calculator.divide(9.0, 2.0)).to eq(4.5)
        expect(calculator.divide(12.0, 6.0)).to eq(2)
      end

      it "should divide two integers" do 
        expect(calculator.divide(5, 2)).to eq(2.5)
        expect(calculator.divide(9, 2)).to eq(4.5)
        expect(calculator.divide(12, 6)).to eq(2)
      end

      it "should return a negative number if one number is negative" do 
        expect(calculator.divide(-12, 6)).to eq(-2)
        expect(calculator.divide(-5.0, 2)).to eq(-2.5)
        expect(calculator.divide(-0.5, 1.125)).to be_within(0.00001).of(-0.5 / 1.125)
      end

      it "should return a postive number if both numbers are negative" do 
        expect(calculator.divide(-12, -6)).to eq(2)
        expect(calculator.divide(-5.0, -2)).to eq(2.5)
        expect(calculator.divide(-0.5, -1.125)).to be_within(0.00001).of(0.5 / 1.125)
      end

      it "should raise an argument error if dividing by zero" do 
        expect{calculator.divide(rand, 0)}.to raise_error(ArgumentError)
        expect{calculator.divide(rand, 0)}.to raise_error(ArgumentError)
        expect{calculator.divide(rand, 0)}.to raise_error(ArgumentError)
      end

      it "should return zero for zero divided by any number" do 
        expect(calculator.divide(0, rand)).to eq(0)
        expect(calculator.divide(0, rand)).to eq(0)
        expect(calculator.divide(0, rand)).to eq(0)
      end
    end

    describe "#pow" do 

      it "should correctly return a number to a power" do 
        expect(calculator.pow(1,7)).to eq(1.0)
        expect(calculator.pow(2,3)).to eq(8.0)
        expect(calculator.pow(3,3.0)).to eq(27.0)
        expect(calculator.pow(1.78184, 1.123123)).to be_within(0.00001).of(1.78184 ** 1.123123)
      end
    end
  end
end