# frozen_string_literal: true

# Contains helper method related to written time
module TimeHelpers
  private

  def time_in_writing(seconds)
    seconds = seconds.to_i
    [hours_in_writting(seconds), minutes_in_writting(seconds), seconds_in_writting(seconds)].compact.join(", ")
  end

  def hours_in_writting(seconds)
    hours = seconds / 3600
    return nil if hours.zero?
    return "an hour" if hours == 1

    "#{hours} hours"
  end

  def minutes_in_writting(seconds)
    minutes = (seconds % 3600) / 60
    return nil if minutes.zero?
    return "a minute" if minutes == 1

    "#{minutes} minutes"
  end

  def seconds_in_writting(seconds)
    seconds = seconds % 60
    return nil if seconds.zero?
    return "a second" if seconds == 1

    "#{seconds} seconds"
  end
end
