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

    class Flower < ColorElement
    end

    class Hand < ColorElement
    end

    class Seashell < ColorElement
    end

    class Star < ColorElement
    end

    class Heart < PositionedColorElement
    end
  end
end
