module Swamp
  class Wrapper < Base
    def initialize(meta_collection)
      @meta_collection = meta_collection
      @page_visited = false
    end

    attr_reader :page_visited

    def explore(url)
      if !page_visited
        visit url
        @page_visited = true
      end
    end

    def scan
      found_snippets = []
      @meta_collection.each do | element_collection |
        found_snippets += element_collection.get.map { | element | Swamp::Builder.new(element).build_snippet }
      end
      found_snippets
    end
  end
end
