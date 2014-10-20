module Swamp
  class Links < Elements
    def get
      elements = []
      page.all('a[href][id]').map do | element |
        if element.visible?
          shine_link %/##{element["id"]}/
          link = Swamp::Link.new(element["id"], element["id"])
          link.prism_selector = "'##{element['id']}'"
          elements << link
        end
      end
      elements
    end
  end
end
