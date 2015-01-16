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

    class FleurDeLisMedium < PositionedColorElement
    end

    class Tower < ColorElement
    end

    class Anchor < ColorElement
    end

    class Flower < PositionedColorElement
    end

    class Hand < PositionedColorElement
    end

    class Seashell < PositionedColorElement
    end

    class Star < PositionedColorElement
    end

    class Heart < PositionedColorElement
    end
  end
end
