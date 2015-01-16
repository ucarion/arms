module Arms
  module Element
    class CrossMoline < ColorElement
    end

    class CrossedKeys < Struct.new(:color_1, :color_2)
    end

    class Sword < Struct.new(:grip_color)
    end

    class Lion < ColorElement
    end

    class FleurDeLisFull < ColorElement
    end

    class FleurDeLisMedium < Struct.new(:color, :position)
      def translation
        case position
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
        end
      end
    end

    class Tower < ColorElement
    end

    class Anchor < ColorElement
    end

    class Flower < ColorElement
    end

    class Hand < ColorElement
    end
  end
end
