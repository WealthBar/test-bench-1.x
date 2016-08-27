module TestBench
  class Output
    class Writer
      attr_accessor :color
      attr_writer :device
      attr_accessor :indentation
      attr_writer :level

      def initialize level=nil
        @level = level
        @indentation = 0
      end

      def self.build device
        instance = new
        instance.device = device
        instance
      end

      def color?
        return color unless color.nil?
        device.tty?
      end

      def decrease_indentation
        self.indentation -= 1
      end

      def device
        @device ||= StringIO.new
      end

      def increase_indentation
        self.indentation += 1
      end

      def level
        @level ||= :normal
      end

      def lower_verbosity
        if level == :verbose
          self.level = :normal
        elsif level == :normal
          self.level = :quiet
        end
      end

      def normal prose, **arguments
        arguments[:render] = false if level == :quiet
        write prose, **arguments
      end

      def quiet prose, **arguments
        write prose, **arguments
      end

      def raise_verbosity
        if level == :quiet
          self.level = :normal
        elsif level == :normal
          self.level = :verbose
        end
      end

      def verbose prose, **arguments
        arguments[:render] = false unless level == :verbose
        write prose, **arguments
      end

      def write prose, bg: nil, fg: nil, render: nil
        render = true if render.nil?

        if render
          indentation = '  ' * self.indentation
          prose.insert 0, indentation
          prose = Palette.apply prose, bg: bg, fg: fg if color?
          prose << $INPUT_RECORD_SEPARATOR
          device.write prose
        end
      end
    end
  end
end
