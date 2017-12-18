module OasParser
  class Path
    attr_accessor :definition, :path, :raw

    def initialize(definition, path, raw)
      @definition = definition
      @path = path
      @raw = raw
    end

    def endpoints
      a = raw.map do |method, definition|
        next unless %w[get head post put patch delete trace options].include? method
        OasParser::Endpoint.new(self, method, definition)
      end

      a.compact
    end

    def parameter_keys
      path.scan(/{(.+?)}/).flatten
    end
  end
end
