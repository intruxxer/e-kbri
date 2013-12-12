require 'rspec/core'
require 'pathname'

module Guard
  class RSpec
    class Command < String
      FAILURE_EXIT_CODE = 2

      attr_accessor :paths, :options

      def initialize(paths, options = {})
        @paths = paths
        @options = options
        super(_parts.join(' '))
      end

      private

      def _parts
        parts = [options[:cmd]]
        parts << _visual_formatter
        parts << _guard_formatter
        parts << "--failure-exit-code #{FAILURE_EXIT_CODE}"
        parts << paths.join(' ')
      end

      def _visual_formatter
        return if _cmd_include_formatter?
        _rspec_formatters || '-f progress'
      end

      def _rspec_formatters
        formatters = ::RSpec::Core::ConfigurationOptions.new([]).parse_options()[:formatters] || nil
        # RSpec's parser returns an array in the format [[formatter, output], ...], so match their format
        # Construct a matching command line option, including output target
        formatters && formatters.map { |formatter| "-f #{formatter.join ' -o '}" }.join(' ')
      end

      def _cmd_include_formatter?
        options[:cmd] =~ /(?:^|\s)(?:-f\s*|--format(?:=|\s+))([\w:]+)/
      end

      def _guard_formatter
        "-r #{File.dirname(__FILE__)}/formatter.rb -f Guard::RSpec::Formatter"
      end
    end
  end
end
