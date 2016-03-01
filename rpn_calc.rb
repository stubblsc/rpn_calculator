##################################################
# RPNCalculator is a module that allows you to
# Do calculations in RPN by calling
# RPNCalculator.start_calculator
##################################################
module RPNCalculator
  # supported operations of the calculator as symbols as to pass to send
  SUPPORTED_OPERATORS = [:+, :-, :*, :/]
  # stack that holds values to perform operations on
  @@value_stack = []

  ################################################
  # self.start_calculator
  # ======================
  # starts calculator to give input to
  ################################################
  def self.start_calculator
    # loop while input is not "q" (quit command)
    while((input = gets.chomp) != "q")
      process_input(input)
    end
  end

  private
    ################################################
    # self.process_input(input)
    # params:
    #   input: data to be processed from user
    # ========================================
    # processes the input to see if it is an
    # operator or operand and responds appropriately
    ################################################
    def self.process_input(input)
      if is_float?(input)
        @@value_stack << input.to_f
      elsif is_operator?(input)
        if enough_values?
          result = perform_operation(@@value_stack.pop, @@value_stack.pop, input.to_sym)
          puts result
          @@value_stack << result
        else
          exit_with_message "Not enough values in stack to perform operation"
        end
      else
        exit_with_message "Invalid character entered: '#{input}' is not valid"
      end
    end

    ################################################
    # self.enough_values
    # return: true if it has at least two values,
    #         otherwise false
    # ============================================
    # checks to see if the value stack has at least
    # two values left in the stack (need two to
    # perform operation)
    ################################################
    def self.enough_values?
      @@value_stack.count >= 2
    end

    ################################################
    # self.is_float?(input)
    # params:
    #   input: data to be processed from user
    # return: true if input is a valid floating
    #         point number, otherwise false
    # ==========================================
    # checks if the input is a valid floating point
    # number
    ################################################
    def self.is_float?(input)
      input.to_f.to_s == input || input.to_i.to_s == input
    end

    ################################################
    # self.is_operation?(input)
    # params:
    #   input: data to be processed from user
    # return: true if input is contained in
    #         SUPPORTED_OPERATORS array, otherwise
    #         false
    # =============================================
    # checks if the input is a valid operator
    ################################################
    def self.is_operator?(input)
      SUPPORTED_OPERATORS.include? input.to_sym
    end

    ################################################
    # self.perform_operation
    # params:
    #   value1: right hand value of operation
    #   value2: left hand value of operation
    #   operation: opertaion to be performed on two
    #              values
    # return: result of operation
    # ==============================================
    # performs correct operation depending on the
    # operator passed
    ################################################
    def self.perform_operation(value1, value2, operator)
      value2.to_f.send(operator, value1.to_f)
    end

    ################################################
    # self.exit_with_message
    # =======================
    # exits the script and prints out error message
    # to STDERR
    ################################################
    def self.exit_with_message(message)
      STDERR.puts "#{message}\nExiting..."
      exit
    end
end
