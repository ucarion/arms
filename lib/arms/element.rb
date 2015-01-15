require 'nokogiri'

module Arms
  module Element
    class SimpleElement
      def members
        []
      end
    end

    class ColorElement < Struct.new(:color)
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
