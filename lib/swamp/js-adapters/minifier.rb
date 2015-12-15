module JavaScript
  class Minifier
    def initialize
      @file_path = File.join(File.dirname(__FILE__), '../', 'js-modules', 'highlight.js')
    end

    def minify
      minified_js = ''
      file = File.new(file_path, 'r')
      file.each_line do |l|
        minified_js += l unless l.include?('module.exports')
      end
      file.close
      minified_js = minified_js.gsub("\n", "")
      minified_js = minified_js.gsub("\"", "'")
      minified_js = minified_js.gsub("    ", " ")
      minified_js = minified_js.gsub("  ", " ")
    end

    private
    attr_reader :file_path
  end
end
