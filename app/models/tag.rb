class Tag < ApplicationRecord
  include ContentInfoCommon
  belongs_to :content
  belongs_to :mst_tag
end
