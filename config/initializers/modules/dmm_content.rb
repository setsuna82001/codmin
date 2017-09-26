module DMMContent
  class << self
    def search str
      # access to top page
      agent = Mechanize.new
      page  = agent.get 'http://www.dmm.com/'
      # get search result page
      page  = page.form_with(action: '/search/'){|form|
        form['searchstr']= str
        form['category']= 'comic'
      }.submit

      # parsing
      page.search('ul#fn-list/li').map &:to_search_data
    end


    def detail url
      url = 'https://book.dmm.com/detail/b508akaeb00004/' # TODO DELETE
      # access to detail page
      agent = Mechanize.new
      page  = agent.get url

      # parsing
      authors = page.search('dl.m-boxDetailProductInfoMainList[1]//a').map(&:text >> :chomp)
      tags    = page.search('dl.m-boxDetailProductInfo__list[6]//a').map(&:text >> :chomp)

      compact %i(authors tags)

    end

  end
end
