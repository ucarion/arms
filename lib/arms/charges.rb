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
        end
      end
    end
  end
end
