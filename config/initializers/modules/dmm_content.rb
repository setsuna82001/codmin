module DMMContent
  PARSE_PATHS = {
    authors:  'dl.m-boxDetailProductInfoMainList[1]//a',
    tags:     'dl.m-boxDetailProductInfo__list[6]//a'
  }
  #=====================================
  # DMMContent::ClassMethods
  #=====================================
  class << self
    # TODO future:cache

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
      page  = agent.get url.to_s rescue return nil

      # parsing
      data  = %i(authors tags).inject([]){|arr, key|
        # parse html
        nodes = page.search PARSE_PATHS[key]
        names = nodes.map(&:text >> :chomp)
        # set data
        names = names.uniq.delete_if &:empty?
        next arr.push [key, names]
      }.to_h
    end

  end
  #=====================================
end
