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
    end

    class Fess < Ordinary
      def initialize(color)
        super(color)
        self.path = "M1.702,192.072l0.155,77.678c-0.451,9.755-0.454,19.435,1.547,28.782 c2.292,27.669,8.44,54.857,17.331,81.702h558.837c4.251-13.72,8.57-27.44,11.219-41.161c3.351-15.216,5.925-30.691,6.808-46.73 l0.929-34.971v-65.299H1.702z"
      end
    end

    class Fess10 < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 1.5 66 L 1.5 131.8125 L 598.5 131.8125 C 598.5 116.96882 598.5 67.881013 598.5 66 L 1.5 66 z M 1.5 197.65625 L 1.5 260.71875 C 1.5 261.64012 1.5250503 262.55099 1.53125 263.46875 L 598.46875 263.46875 C 598.47495 262.55099 598.5 261.64012 598.5 260.71875 C 598.5 191.08969 598.5 235.0393 598.5 197.65625 L 1.5 197.65625 z M 7.53125 329.28125 C 11.71764 352.59446 17.948016 374.50667 25.78125 395.09375 L 574.21875 395.09375 C 582.05198 374.50667 588.28236 352.59446 592.46875 329.28125 L 7.53125 329.28125 z M 58.5 460.9375 C 73.666772 485.32043 90.910056 507.21027 109.0625 526.75 L 490.9375 526.75 C 509.08994 507.21027 526.33323 485.32043 541.5 460.9375 L 58.5 460.9375 z M 183.53125 592.5625 C 244.90776 637.45727 298.23105 657.82288 299.6875 658.375 L 300.3125 658.375 C 301.76895 657.82288 355.09224 637.45727 416.46875 592.5625 L 183.53125 592.5625 z "
      end
    end

    class Pale < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 232.96875,2.1875 L 232.96875,625 C 271.84891,647.84342 300,658.5 300,658.5 C 300,658.5 328.15235,647.84243 367.03125,625 L 367.03125,2.1875 L 232.96875,2.1875 z"
      end
    end

    class Pale5 < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 170.498,1.5 L 84.503,1.5 L 84.503,497.996 C 111.185,531.885 141.361,559.877 170.498,582.455 L 170.498,1.5 M 342.497,1.5 L 256.502,1.5 L 256.502,637.748 C 282.456,651.411 299.504,657.825 299.504,657.825 C 299.504,657.825 316.555,651.408 342.497,637.752 L 342.497,1.5 M 514.496,1.5 L 428.501,1.5 L 428.501,582.458 C 457.637,559.88 487.815,531.887 514.496,497.999 L 514.496,1.5"
      end
    end

    class Pale6 < Ordinary
      def initialize(color)
        super(color)
        self.path = "M 198.496,1.5 L 98.497,1.5 L 98.497,516.037 C 130.605,552.685 166.277,581.603 198.496,603.501 L 198.496,1.5 M 398.503,1.5 L 298.504,1.5 L 298.504,657.825 C 298.504,657.825 343.477,640.899 398.503,603.505 L 398.503,1.5 M 596.998,1.5 L 498.502,1.5 L 498.502,516.04 C 552.842,454.015 596.998,369.833 596.998,260.052 L 596.998,1.5"
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
