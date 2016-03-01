require 'spec_helper'

describe RPNCalculator do
  before(:each) { RPNCalculator.class_variable_set :@@values_stack, [] }

  describe '#process_input' do
    it 'should add a value to the stack if the input is a floating point number' do
      RPNCalculator.class_variable_set :@@value_stack, [0,1,2]
      expect(RPNCalculator.send(:process_input, "37")).to eq([0,1,2,37])
      expect(RPNCalculator.send(:process_input, "1123")).to eq([0,1,2,37,1123])
    end

    context 'at least two elements in value stack' do
      it 'should perform an operation if the input is an operator' do
        RPNCalculator.class_variable_set :@@value_stack, [0.5,-1,2]
        expect(RPNCalculator.send(:process_input, "+")).to eq([0.5,1])
        expect(RPNCalculator.send(:process_input, "-")).to eq([-0.5])
      end
    end
  end

  describe '#enough_values?' do
    it 'should return true if there are more than two values in the stack' do
      RPNCalculator.class_variable_set :@@value_stack, (0..(rand(100)+2)).to_a
      expect(RPNCalculator.send(:enough_values?)).to be_truthy
    end
    it 'should return true if there are exactly two values in the stack' do
      RPNCalculator.class_variable_set :@@value_stack, [0,1]
      expect(RPNCalculator.send(:enough_values?)).to be_truthy
    end

    it 'should return false if there is only one value in the stack' do
      RPNCalculator.class_variable_set :@@value_stack, [0]
      expect(RPNCalculator.send(:enough_values?)).to be_falsey
    end

    it 'should return false if there is empty' do
      RPNCalculator.class_variable_set :@@value_stack, []
      expect(RPNCalculator.send(:enough_values?)).to be_falsey
    end
  end

  describe '#is_float?' do
    it 'should return true if the input is a string representation of a floating point number' do
      expect(RPNCalculator.send(:is_float?, "12")).to be_truthy
      expect(RPNCalculator.send(:is_float?, "12.21")).to be_truthy
    end

    it 'should return false if the input is not a string representation of a floating point number' do
      expect(RPNCalculator.send(:is_float?, "12d")).to be_falsey
      expect(RPNCalculator.send(:is_float?, "+")).to be_falsey
    end
  end

  describe '#is_operator?' do
    it 'should return true if the input is a string representation of a valid operator' do
      expect(RPNCalculator.send(:is_operator?, "+")).to be_truthy
      expect(RPNCalculator.send(:is_operator?, "-")).to be_truthy
      expect(RPNCalculator.send(:is_operator?, "*")).to be_truthy
      expect(RPNCalculator.send(:is_operator?, "/")).to be_truthy
    end

    it 'should return false if the input is not a string representation of a valid operator' do
      expect(RPNCalculator.send(:is_operator?, "12d")).to be_falsey
      expect(RPNCalculator.send(:is_operator?, "12.12")).to be_falsey
      expect(RPNCalculator.send(:is_operator?, "+123")).to be_falsey
    end
  end

  describe '#perform_operation' do
    it 'should perform addition if the operation is +' do
      expect(RPNCalculator.send(:perform_operation, 13, 34, :+)).to eq(47)
    end

    it 'should perform subtraction if the operation is -' do
      expect(RPNCalculator.send(:perform_operation, 13, 34, :-)).to eq(21)
    end

    it 'should perform multiplication if the operation is *' do
      expect(RPNCalculator.send(:perform_operation, 13, 34, :*)).to eq(442)
    end

    it 'should perform division if the operation is /' do
      expect(RPNCalculator.send(:perform_operation, 26, 13, :/)).to eq(0.5)
    end
  end
end
