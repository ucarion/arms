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

    class Ordinary < LineElement
    end

    class Fess < Ordinary
      def initialize(color)
        super(color)
        self.path = "M1.702,192.072l0.155,77.678c-0.451,9.755-0.454,19.435,1.547,28.782 c2.292,27.669,8.44,54.857,17.331,81.702h558.837c4.251-13.72,8.57-27.44,11.219-41.161c3.351-15.216,5.925-30.691,6.808-46.73 l0.929-34.971v-65.299H1.702z"
      end
    end

    class Pale < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 232.96875,2.1875 L 232.96875,625 C 271.84891,647.84342 300,658.5 300,658.5 C 300,658.5 328.15235,647.84243 367.03125,625 L 367.03125,2.1875 L 232.96875,2.1875 z"
      end
    end

    class Chief < Ordinary
      def initialize(color)
        super(color)
        self.path = "M1.23,2.019L598.508,1.97v195.591l-597.55-0.373C3.739,197.323,1.342,5.478,1.23,2.019z"
      end
    end

    class Cross < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 374.496,1.5 L 224.502,1.5 L 224.502,223.818 L 1.5,223.818 C 1.5,235.298 1.5,247.368 1.5,260.052 C 1.5,301.57 7.82,339.441 18.613,373.821 L 224.502,373.821 L 224.502,619.29 C 267.773,645.696 300.003,657.825 300.003,657.825 C 300.003,657.825 331.724,645.891 374.496,619.902 L 374.496,373.821 L 581.385,373.821 C 592.177,339.441 598.497,301.57 598.497,260.052 L 598.497,223.818 L 374.496,223.818 L 374.496,1.5"
      end
    end

    class Chevron < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 300.004,103.456 L 21.159,382.3 C 38.057,432.188 64.388,474.572 94.248,510.024 L 300.004,304.273 L 505.755,510.023 C 535.614,474.572 561.945,432.182 578.843,382.294 L 300.004,103.456"
      end
    end

    class DoubleChevron < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 300,61.28125 L 8.375,333.8125 C 14.355129,364.89167 23.97602,393.45879 36.15625,419.65625 L 300,178.78125 L 563.84375,419.71875 C 576.06438,393.44474 585.70664,364.77941 591.6875,333.59375 L 300,61.28125 z M 300,301.28125 L 80.1875,492.40625 C 96.558827,513.99812 114.38454,533.27603 132.59375,550.375 L 300,412.75 L 467.375,550.40625 C 485.62493,533.27204 503.50349,513.95964 519.90625,492.3125 L 300,301.28125 z "
      end
    end

    class Bande < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 1.5,0.823 C 1.5,0.823 1.5,12.208 1.5,128.103 L 443.896,570.499 C 485.929,535.522 528.529,489.271 558.337,430.382 L 129.46,1.5 L 1.5,1.5 L 1.5,0.823"
      end
    end

    class Barre < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 597.998,1.5 L 470.037,1.5 L 41.162,430.381 C 70.971,489.27 113.57,535.52 155.605,570.496 L 597.998,128.103 L 597.998,1.5"
      end
    end

    class Saltire < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 1.5,2.1875 L 1.5,100.78125 L 204.59375,303.875 L 54.4375,454.03125 C 79.0865,495.48648 109.77608,530.02376 141.125,558.15625 L 300,399.28125 L 458.875,558.15625 C 490.22392,530.02376 520.9135,495.48648 545.5625,454.03125 L 395.40625,303.875 L 598.5,100.78125 L 598.5,2.1875 L 506.28125,2.1875 L 300,208.46875 L 93.71875,2.1875 L 1.5,2.1875 z"
      end
    end
  end

end
