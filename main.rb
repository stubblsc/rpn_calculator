# main program that starts the calculator using the RPNCalculator module
require './rpn_calc'
begin
  # start calculator
  RPNCalculator.start_calculator
# catch interrupt
rescue SystemExit, Interrupt
  STDERR.puts "Interrupt called\nExiting..."
# catch other errors
rescue => e
  STDERR.puts "Error Occurred: #{e}\nExiting..."
end
