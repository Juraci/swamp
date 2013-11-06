module Swamp
  class Links < Elements
    def get
      elements = []
      page.all('a[href][id]').map do | element |
        if element.visible?
          shine_link %/##{element["id"]}/
          elements << Swamp::Link.new(element["id"], element["id"])
        end
      end
      elements
    end
  end
end
