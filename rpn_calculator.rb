require 'bigdecimal'

class RpnCalculator
  OPERATOR_REGEX = /^[\/*+-]$/    # http://rubular.com/r/aaLpCOaTcV
  NUMBER_REGEX = /^-?[\d\.]+$/    # http://rubular.com/r/WeHwuI0Sdw

  def initialize
    @values = []
  end

  def input(instruction)
    instruction = instruction.to_s
    return unless instruction.match(OPERATOR_REGEX) || instruction.match(NUMBER_REGEX)

    if instruction.match(OPERATOR_REGEX)
      handle_operation(instruction)
    else
      @values << BigDecimal.new(instruction)
      @values[0]
    end
  end

  def handle_operation(instruction)
    unless instruction.match(OPERATOR_REGEX)
      raise "ERROR: this is an invalid operation"
    end
    return if @values.size < 2

    right_val = @values.pop
    left_val = @values.pop
    result = left_val.send(instruction, right_val)

    if result.finite?
      @values << result
      @values[0]
    else
      result
    end
  end
end
