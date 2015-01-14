require 'nokogiri'

module Arms
  module Element
    class Element
      def to_svg
        raise NotImplementedError
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

        gloss_path = "M299.714,658.864c0,0,298.5-112.32,298.5-397.772s0-258.552,0-258.552h-597v258.552 C1.214,546.543,299.714,658.864,299.714,658.864z"

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

        self.path = "M300,658.5c0,0,298.5-112.32,298.5-397.772V2.176H1.5v258.552 C1.5,546.18,300,658.5,300,658.5z"
        self.stroke = '#000000'
        self.stroke_width = 3
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

    class Lozengy < LineElement
      def initialize(color)
        super(color)
        self.path = "M 120.003,109.495 L 120.003,109.495 M 240,109.495 L 240,109.495 M 359.997,109.495 L 359.997,109.495 M 480.003,109.495 L 480.003,109.495 M 61.188,1.675 L 58.812,1.675 L 1.5,106.74 C 1.5,108.551 1.5,110.378 1.5,112.251 L 60,219.494 L 5.852,318.766 C 7.613,330.381 9.882,341.659 12.604,352.611 L 60,439.498 L 53.278,451.82 C 68.488,477.713 86.102,500.926 104.776,521.583 L 60,439.498 L 120.003,329.5 L 60,219.493 L 120.003,109.495 L 61.188,1.675 M 181.185,1.675 L 178.809,1.675 L 120.003,109.495 L 179.997,219.493 L 120.003,329.5 L 179.997,439.498 L 124.189,541.82 C 152.09,569.272 181.263,591.453 207.653,608.794 L 240,549.496 L 179.997,439.498 L 240,329.5 L 179.997,219.493 L 240,109.495 L 181.185,1.675 M 301.19,1.675 L 298.815,1.675 L 240,109.495 L 300.003,219.493 L 240,329.5 L 300.003,439.498 L 240,549.496 L 298.97,657.6 C 299.651,657.868 300.003,658 300.003,658 C 300.003,658 300.356,657.867 301.036,657.6 L 359.997,549.496 L 300.003,439.498 L 359.997,329.5 L 300.003,219.493 L 359.997,109.495 L 301.19,1.675 M 421.188,1.675 L 418.811,1.675 L 359.997,109.495 L 420,219.493 L 359.997,329.5 L 420,439.498 L 359.997,549.496 L 392.345,608.797 C 418.735,591.456 447.914,569.27 475.815,541.818 L 420.001,439.499 L 480.004,329.501 L 420.001,219.494 L 480.004,109.496 L 421.188,1.675 M 541.185,1.675 L 538.81,1.675 L 480.003,109.495 L 539.997,219.493 L 480.003,329.5 L 539.997,439.498 L 495.233,521.572 C 513.906,500.916 531.509,477.715 546.719,451.821 L 539.996,439.498 L 587.392,352.61 C 590.114,341.659 592.382,330.381 594.144,318.766 L 539.996,219.493 L 598.496,112.25 L 598.496,106.739 L 541.185,1.675"
      end
    end

    class Ordinary < LineElement
      def load_path
        class_name = self.class.name.split('::').last
        relative_path = File.join("../elements/paths", class_name)
        file_name = File.expand_path(relative_path, __FILE__)

        File.read(file_name)
      end
    end
  end
end

require 'arms/elements/ordinaries'
