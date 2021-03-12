# frozen_string_literal: true

module MastermindGenerator
  # Exception for ending timer without starting it before
  class TimerNotStartedError < StandardError
    def message
      "Timer is not started! To stop or pause a timer, you need to start it first."
    end
  end

  # A simple timer
  # Calculates the time between start and end
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
      pause
      elapsed_time = stop_time - start_time
      start
      elapsed_time
    end

    def duration_as_text
      time_in_writing(duration)
    end

    private

    attr_accessor :start_time, :stop_time
  end
end
