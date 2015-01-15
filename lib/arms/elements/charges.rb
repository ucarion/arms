module Arms
  module Element
    class CrossMoline < Charge
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end

    class CrossedKeys < Charge
      def initialize(key_a_color, key_b_color)
        @key_a_color = key_a_color
        @key_b_color = key_b_color
      end

      def to_svg
        xml_data = load_asset('CrossedKeys').
          gsub('{{COLOR_1}}', @key_a_color).
          gsub('{{COLOR_2}}', @key_b_color)

        Nokogiri::XML(xml_data).root
      end
    end
  end
end
