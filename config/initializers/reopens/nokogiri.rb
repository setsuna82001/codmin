module Nokogiri
  module XML
    class Element
      def to_search_data
        # read data
        imgdata = self.at 'span/img'
        baseurl = self.at('a').attr :href
        # set data
        title = imgdata.attr :alt
        img   = imgdata.attr :src
        url   = URI::normalurl baseurl
        # return
        compact %i(title url img)
      end
    end
  end
end
