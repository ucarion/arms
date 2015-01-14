module Arms
  module Element
    class FleurDeLis < Fur
      def to_svg
        Nokogiri::XML(load_path).root
      end
    end
  end
end
