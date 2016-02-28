module TestBench
  class Telemetry
    module Registry
      def self.instance
        @instance ||= TestBench::Registry.new Telemetry
      end

      def self.get binding
        instance.get binding
      end
    end
  end
end