module Arms
  module Element
    class FleurDeLis < Fur
      def to_svg
        Nokogiri::XML(load_asset('FleurDeLis')).root
      end
    end

    class Ermine < Fur
      def to_svg
        Nokogiri::XML(load_asset('Ermine')).root
      end
    end
  end
end
