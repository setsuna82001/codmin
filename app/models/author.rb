class Author < ApplicationRecord
  include ContentInfoCommon
  belongs_to :content
  belongs_to :mst_author
end
