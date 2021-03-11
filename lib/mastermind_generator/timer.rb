# frozen_string_literal: true

module MastermindGenerator
  # Exception for ending timer without starting it before
  class TimerNotStartedError < StandardError; end

  # A simple timer
  # Calculates the time between start and end times
  class Timer
    include TimeHelpers

    def start
      @stop_time = nil
      @start_time ||= Time.new # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def stop
      raise TimerNotStartedError unless start_time

      self.stop_time = Time.new
    end

    alias pause stop

    def duration
      stop_time - start_time
    end

    def duration_as_text
      time_in_writing(stop_time - start_time)
    end

    private

    attr_accessor :start_time, :stop_time
  end
end
