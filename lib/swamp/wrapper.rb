module Swamp
  class Wrapper < Base
    attr_reader :page_visited

    def initialize(meta_collection, setup)
      @meta_collection = meta_collection
      @page_visited = false
      @setup = setup
    end

    def explore(url)
      if !page_visited
        visit url.gsub("\n", "")
        @page_visited = true
      end
    end

    def scan
      found_snippets = []
      @meta_collection.each do | element_collection |
        found_snippets += element_collection.get.map { | element | build_snippet(element) }
      end
      found_snippets
    end

    private
    def build_snippet(element)
      @setup.builder.build_snippet(element)
    end
  end
end
