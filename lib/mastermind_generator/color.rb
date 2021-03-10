# frozen_string_literal: true

module MastermindGenerator
  # Respresents single Color object
  # - color name
  # - code(first char of color name)
  # - input_code (using for asking guess)
  class Color
    attr_reader :value

    # Color.blue('blue') # => <#... @value='blue'>
    # Color.new('green') # => <#... @value='green'>
    #
    # Creates a new +Color+ object and return it.
    #
    # @param [String] value
    def initialize(value)
      @value = value
    end

    # color = Color.new('red')
    # color.code # => 'r'
    #
    # Returns first character of +color.value+
    def code
      value[0]
    end
  end
end
