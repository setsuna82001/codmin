FactoryGirl.define do
  factory :content do
    title  'さんぷる'
    url  'https://book.dmm.com/detail/sample/'
    img  'https://pics.dmm.com/digital/e-book/sample/sample.jpg'

    after(:create) do |content|
      3.times{
        content.mst_tags << create(:mst_tag)
        content.mst_authors << create(:mst_author)
      }
    end

  end
end
