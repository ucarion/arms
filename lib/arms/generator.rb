module Arms
  class Generator
    include Element

    def self.generate
      coat = Renderer.new
      coat << DivisionDefinitions.new

      case rand(3)
      when 0
        rand_undivided(coat)
      when 1
        rand_per_cross(coat)
      when 2
        rand_per_chevron(coat)
      end

      coat << OutlineElement.new << GlossElement.new
    end

    private

    UNDIVIDED_CHARGES = [FleurDeLisFull, Lion, Hand, Tower, Sword, Anchor]
    PER_CROSS_CHARGES = [FleurDeLisMedium, Star, Heart, Seashell]
    PER_CHEVRON_CHARGES = PER_CROSS_CHARGES

    def self.rand_undivided(coat)
      color_a, color_b = color_classes.map(&:sample)
      charge = UNDIVIDED_CHARGES.sample

      coat << BackgroundElement.new(color_a)
      coat << charge.new(color_b)
    end

    def self.rand_per_cross(coat)
      color_a, color_b = color_classes.map(&:sample)
      charge_1 = PER_CROSS_CHARGES.sample
      charge_2 = PER_CROSS_CHARGES.sample

      coat << BackgroundElement.new(color_a)
      coat << PerCross.new(color_b)

      coat << charge_1.new(color_a, :cross_top_left)
      coat << charge_2.new(color_b, :cross_top_right)
      coat << charge_2.new(color_b, :cross_bottom_left)
      coat << charge_1.new(color_a, :cross_bottom_right)
    end

    def self.rand_per_chevron(coat)
      charge_1, charge_2, charge_3 = chevron_charges
      color_a, color_b = color_classes.map(&:sample)

      coat << BackgroundElement.new(color_a)
      coat << Chevron.new(color_b)

      coat << charge_1.new(color_b, :chevron_top_left)
      coat << charge_2.new(color_b, :chevron_top_right)
      coat << charge_3.new(color_b, :chevron_bottom)
    end

    def self.color_classes
      [Color::METALS, Color::COLORS].shuffle
    end

    def self.chevron_charges
      if rand > 0.5
        PER_CHEVRON_CHARGES.sample(3)
      else
        [PER_CHEVRON_CHARGES.sample] * 3
      end
    end
  end
end
