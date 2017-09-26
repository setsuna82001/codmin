module DMMContent
  #=====================================
  # DMMContent::ClassMethods
  #=====================================
  class << self
    # TODO cache

    #===================================
    # DMMContent::search
    #===================================
    def search str
      # access to top page
      agent = Mechanize.new
      page  = agent.get 'http://www.dmm.com/'
      # get search result page
      page  = page.form_with(action: '/search/'){|form|
        form['searchstr']= str.to_s
        form['category']= 'comic'
      }.submit

      # parsing
      page.search('ul#fn-list/li').map &:to_search_data
    end

    #===================================
    # DMMContent::detail
    #===================================
    def detail url
      # access to detail page
      agent = Mechanize.new
      page  = agent.get url.to_s

      # parsing
      authors = page.search('dl.m-boxDetailProductInfoMainList[1]//a').map(&:text >> :chomp)
      tags    = page.search('dl.m-boxDetailProductInfo__list[6]//a').map(&:text >> :chomp)

      # return
      compact %i(authors tags)
    end

  end
  #=====================================
end
