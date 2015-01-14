require_relative 'element'
require_relative 'color'

include Arms

root = Element::RootElement.new.to_svg
root.at_css('svg') <<
  Element::BackgroundElement.new(Color::ARGENT).to_svg <<
  Element::DoubleChevron.new(Color::GULES).to_svg <<
  Element::OutlineElement.new.to_svg <<
  Element::GlossElement.new.to_svg

File.write('foobar.svg', root.to_s)
