require_relative 'rpn_calculator'
require 'minitest/spec'
require 'minitest/autorun'

describe RpnCalculator do
  def setup
    @calculator = RpnCalculator.new
  end

  describe "inputting a number" do
    it "returns the last number" do
      @calculator.input(3).must_equal 3
    end
  end

  describe "addition" do
    it "returns the result of a calculation" do
      @calculator.input(2)
      @calculator.input(2)
      @calculator.input('+').must_equal(4)
    end

    it "handles multiple calculations in a row" do
      @calculator.input(2)
      @calculator.input(2)
      @calculator.input(2)
      @calculator.input(2)
      @calculator.input('+')
      @calculator.input('+')
      @calculator.input('+').must_equal(8)
    end

    it "returns nil if there are not enough numbers for addition" do
      @calculator.input(2)
      @calculator.input('+').must_equal(nil)
    end
  end

  describe "subtraction" do
    it "subtracts the last two numbers" do
      @calculator.input(4)
      @calculator.input(2)
      @calculator.input('-').must_equal(2)
    end

    it "returns nil without enough numbers to subtract" do
      @calculator.input(4)
      @calculator.input(2)
      @calculator.input('-').must_equal(2)
      @calculator.input('-').must_equal(nil)
    end
  end

  describe "multiplication" do
    it "multiplies two numbers" do
      @calculator.input(3)
      @calculator.input(2)
      @calculator.input('*').must_equal(6)
    end

    it "multiplies negative numbers" do
      @calculator.input(-3)
      @calculator.input(-3)
      @calculator.input('*').must_equal(9)
    end
  end

  describe "division" do
    it "divides 2 numbers" do
      @calculator.input(10)
      @calculator.input(5)
      @calculator.input('/').must_equal(2)
    end

    it "can return decimal numbers" do
      @calculator.input(3)
      @calculator.input(2)
      @calculator.input('/').must_equal(1.5)
    end
  end

  describe "complex calculations" do
    it "works" do
      @calculator.input(-3)
      @calculator.input(-2)
      @calculator.input('*')
      @calculator.input(5)
      @calculator.input('+').must_equal(11)
    end

    it "works again" do
      @calculator.input(2)
      @calculator.input(9)
      @calculator.input(3)
      @calculator.input('+')
      @calculator.input('*').must_equal(24)
    end

    it "works againnnn" do
      @calculator.input(20)
      @calculator.input(13)
      @calculator.input('-')
      @calculator.input(2)
      @calculator.input('/').must_equal(3.5)
    end
  end

  describe "special numbers" do
    it "can return Infinity" do
      @calculator.input(1)
      @calculator.input(0)
      assert @calculator.input('/').infinite?
    end

    it "does not store Infinity" do
      @calculator.input(1)
      @calculator.input(0)
      @calculator.input('/')

      @calculator.input(1)
      @calculator.input('3.33')
      @calculator.input('+').must_equal(4.33)
    end

    it "can return NaN" do
      @calculator.input(0)
      @calculator.input(0)
      assert @calculator.input('/').nan?
    end

    it "does not store Nan" do
      @calculator.input(0)
      @calculator.input(0)
      @calculator.input('/')

      @calculator.input(2)
      @calculator.input(2)
      @calculator.input('+').must_equal(4)
    end
  end
end
