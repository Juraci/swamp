module Swamp
  class Links < Elements
    def get
      elements = []
      page.all('a[href]').map do | element |
        if element.visible?
          if has_id?(element)
            elements << Swamp::Link.new(element["id"], element["id"])
          end
        end
      end
      elements
    end
  end
end
