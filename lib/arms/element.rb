require 'nokogiri'

module Arms
  module Element
    class SimpleElement
      def members
        []
      end
    end

    class ColorElement
      attr_accessor :color

      def initialize(color)
        self.color = color
      end

      def members
        [:color]
      end
    end

    class PositionedColorElement
      attr_accessor :color, :position

      def members
        [:color, :position]
      end

      def initialize(color, position = :center)
        self.color = color
        self.position = position
      end

      def translation
        case position
        when :center
          "translate(0, 0)"

        when :pale_left
          "translate(-150, 0)"
        when :pale_right
          "translate(150, 0)"

        when :cross_top_left
          "translate(-150, -130)"
        when :cross_top_right
          "translate(150, -130)"
        when :cross_bottom_left
          "translate(-130, 170)"
        when :cross_bottom_right
          "translate(130, 170)"

        when :chevron_top_left
          "translate(-170, -130)"
        when :chevron_top_right
          "translate(170, -130)"
        when :chevron_bottom
          "translate(0, 200)"
        end
      end
    end

    class RootElement < SimpleElement
    end

    class DivisionDefinitions < SimpleElement
    end

    class PaleLeft < SimpleElement
    end

    class PaleRight < SimpleElement
    end

    class GlossElement < SimpleElement
    end

    class BackgroundElement < Struct.new(:fill)
    end

    class OutlineElement < SimpleElement
    end
  end
end
