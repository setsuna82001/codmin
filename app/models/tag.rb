class Tag < ApplicationRecord
  include ContentInfo
  belongs_to :content
  belongs_to :mst_tag
end
