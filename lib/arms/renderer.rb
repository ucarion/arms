module Arms
  class Renderer
    attr_accessor :doc

    def initialize(root: :root_element)
      self.doc = Nokogiri::XML(fetch_svg_template(root))
    end

    def <<(element)
      svg_data = if element.instance_of?(Renderer)
        element.to_node
      else
        data = fetch_svg_template(element.class.name)

        element.members.each do |key|
          if key == :position
            data.gsub!("{{TRANSLATION}}", element.translation)
          else
            data.gsub!("{{#{key.upcase}}}", element.send(key))
          end
        end

        data
      end

      doc.root << svg_data
      self
    end

    def to_node
      doc.root
    end

    private

    def fetch_svg_template(name)
      relative_path = "../elements/#{snakeify(name)}.svg"

      File.read(File.expand_path(relative_path, __FILE__))
    end

    def snakeify(s)
      s.to_s.split('::').last.gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase
    end
  end
end
