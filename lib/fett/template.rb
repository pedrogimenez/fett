require "tilt"

module Fett
  class Template
    def initialize(template_name, params = {})
      @name = template_name
      @params = params
    end

    def content
      parse_template(@name, @params)
    end

    private

    def parse_template(template_name, params)
      template_name ||= "rb"

      template = Tilt.new(path_for_template(template_name))

      template.render(Object.new, params)
    end

    def path_for_template(template_name)
      File.expand_path("../../../templates/#{template_name}.xml.erb", __FILE__)
    end
  end
end
