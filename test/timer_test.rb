# frozen_string_literal: true

require "./test/test_helper"

class TimerTest < Minitest::Test
  include MastermindGenerator

  def test_it_exists
    timer = Timer.new

    assert_instance_of Timer, timer
  end

  def test_it_starts
    timer = Timer.new

    assert_in_delta Time.new, timer.start, 0.001
  end

  def test_it_ends
    timer = Timer.new
    timer.start

    assert_in_delta Time.new, timer.stop, 0.001
  end

  def test_it_raises_error_when_try_stopping_before_starting
    timer = Timer.new

    assert_raises(TimerNotStartedError) { timer.stop }
  end

  def test_it_returns_duration_as_secs
    timer = Timer.new
    timer.start
    sleep(2)
    timer.stop

    assert_in_delta 2, timer.duration, 0.01
  end

  def test_it_returns_duration_as_text
    timer = Timer.new
    timer.start
    sleep(2)
    timer.stop

    assert_equal "2 seconds", timer.duration_as_text
  end

  def test_its_duration_single_aware
    timer = Timer.new
    timer.start
    sleep(1)
    timer.stop

    assert_equal "a second", timer.duration_as_text
  end
end
