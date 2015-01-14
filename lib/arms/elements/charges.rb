module Arms
  module Element
    class CrossMoline < Charge
      def initialize(color)
        super(color)
        self.path = load_path
      end
    end
  end
end
