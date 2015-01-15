module Arms
  module Element
    class Fess < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Fess10 < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Pale < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Pale5 < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Pale6 < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Chief < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Cross < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Chevron < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class DoubleChevron < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class TripleChevron < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Bande < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Barre < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Pall < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Saltire < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Lozengy < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Gyronny < Ordinary
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class Fret < Ordinary
      def initialize(color)
        self.color = color
      end

      def to_svg
        xml_data = load_asset('Fret').gsub('{{COLOR}}', self.color)

        Nokogiri::XML(xml_data).root
      end
    end
  end
end
