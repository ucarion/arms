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
  end
end
