require 'nokogiri'

module Arms
  module Element
    class Element
      def to_svg
        raise NotImplementedError
      end

      def load_path
        class_name = self.class.name.split('::').last
        relative_path = File.join("../elements/paths", class_name)
        file_name = File.expand_path(relative_path, __FILE__)

        File.read(file_name).strip
      end
    end

    class RootElement < Element
      def to_svg
        Nokogiri::XML::Builder.new do |xml|
          xml.svg(xmlns: "http://www.w3.org/2000/svg", width: 600, height: 660) {}
        end.doc
      end
    end

    class Division < Element
      def self.definitions
        Nokogiri::XML::Builder.new do |xml|
          xml.defs {
            xml.clipPath(id: :per_pale_left) {
              xml.rect(x: 0, y: 0, width: 300, height: 660)
            }

            xml.clipPath(id: :per_pale_right) {
              xml.rect(x: 300, y: 0, width: 300, height: 660)
            }
          }
        end.doc.root
      end
    end

    class PaleLeft < Division
      def to_svg
        Nokogiri::XML::Builder.new do |xml|
          xml.g('clip-path' => 'url(#per_pale_left)')
        end.doc.root
      end
    end

    class PaleRight < Division
      def to_svg
        Nokogiri::XML::Builder.new do |xml|
          xml.g('clip-path' => 'url(#per_pale_right)')
        end.doc.root
      end
    end

    class GlossElement < Element
      def to_svg
        gradient_parameters = {
          id: 'Gloss_1_1',
          cx: '218.5737',
          cy: '323.3716',
          r: '300',
          gradientTransform: 'matrix(1.3532 0 0 1.3489 -74.031 -216.2625)',
          gradientUnits: 'userSpaceOnUse'
        }

        gloss_path = load_path

        Nokogiri::XML::Builder.new do |xml|
          xml.g {
            xml.radialGradient(gradient_parameters) {
              xml.stop(offset: '0', style: 'stop-color:#FFFFFF;stop-opacity:0.3137')
              xml.stop(offset: '0.19', style: 'stop-color:#FFFFFF;stop-opacity:0.251')
              xml.stop(offset: '0.6', style: 'stop-color:#6B6B6B;stop-opacity:0.1255')
              xml.stop(offset: '1', style: 'stop-color:#000000;stop-opacity:0.1255')
            }

            xml.path(fill: 'url(#Gloss_1_1)', d: gloss_path)
          }
        end.doc.root
      end
    end

    class PathElement < Element
      attr_accessor :color, :stroke, :stroke_width, :path

      def initialize(color)
        self.color = color
      end

      def to_svg
        Nokogiri::XML::Builder.new do |xml|
          xml.path(fill: color, stroke: stroke, stroke_width: stroke_width, d: path)
        end.doc.root
      end
    end

    class BackgroundElement < PathElement
      def initialize(color)
        super(color)

        self.path = load_path
        self.stroke = '#000000'
        self.stroke_width = 3
      end
    end

    class FleurDeLis < Element
      def to_svg
        Nokogiri::XML(load_path).root
      end
    end

    class OutlineElement < BackgroundElement
      def initialize
        super(:none)
      end
    end

    class LineElement < PathElement
      def initialize(color)
        super(color)

        self.stroke = :none
        self.stroke_width = 0
      end
    end

    class Ordinary < LineElement
    end
  end
end

require 'arms/elements/ordinaries'
