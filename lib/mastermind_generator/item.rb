# frozen_string_literal: true

module MastermindGenerator
  # Respresents single Item object
  # - item name
  # - code(first char of item name)
  # - input_code (using for asking guess)
  class Item
    attr_reader :value

    # Item.new('blue')  # => <#... @value='blue'>
    # Item.new('green') # => <#... @value='green'>
    #
    # Creates a new +Item+ object and return it.
    #
    # @param [String] value
    def initialize(value)
      @value = value
    end

    # item = Item.new('red')
    # item.code # => 'r'
    #
    # Returns first character of +item.value+
    def code
      value[0]
    end
  end
end
