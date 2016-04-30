require_relative 'rpn_calculator'

calculator = RpnCalculator.new
print "> "

$stdin.each_line do |line|
  if line.match(/^[q\n]$/)
    exit
  end

  result = calculator.input(line.chomp)
  if result.nil?
    puts
  else
    puts sprintf('%g', result)
  end

  print "> "
end
