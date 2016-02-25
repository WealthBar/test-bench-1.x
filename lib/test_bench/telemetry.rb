module TestBench
  class Telemetry < Struct.new :files, :passes, :failures, :skips, :assertions, :start_time, :stop_time
    attr_writer :clock

    def self.build
      instance = new [], 0, 0, 0, 0
      instance
    end

    def << other
      self.assertions += other.assertions
      self.passes += other.passes
      self.files.concat other.files
      self.failures += other.failures
      self.skips += other.skips
      self.start_time = [start_time, other.start_time].compact.min
      self.stop_time = [stop_time, other.stop_time].compact.max
    end

    def + other
      result = self.dup
      result << other
      result
    end

    def asserted
      self.assertions += 1
    end

    def clock
      @clock ||= Time
    end

    def elapsed_time
      stop_time - start_time
    end

    def failed?
      not passed?
    end

    def file_executed file
      files << file
    end

    def passed?
      failures.zero?
    end

    def started
      self.start_time = clock.now
    end

    def stopped
      self.stop_time = clock.now
    end

    def test_failed
      self.failures += 1
    end

    def test_passed
      self.passes += 1
    end

    def test_skipped
      self.skips += 1
    end

    def tests
      failures + passes + skips
    end

    def self.configure receiver
      instance = build
      receiver.telemetry = instance
    end
  end
end
