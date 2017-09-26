class Author < ApplicationRecord
  include ContentInfo
  belongs_to :content
  belongs_to :mst_author
end


__END__
Author;
MstAuthor.create(id: 1, name: "a-auth");
Content.create(id: 1,title: 'a-content', img_url: 'a-img');
Author.create(id: 1, content_id: 1, mst_author_id: 1);
Content.first.mst_authors
