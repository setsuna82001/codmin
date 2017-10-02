class Author < ApplicationRecord
  include ContentInfo
  belongs_to :content
  belongs_to :mst_author
end
