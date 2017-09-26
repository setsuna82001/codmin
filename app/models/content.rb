class Content < ApplicationRecord
  # tag side
  has_many :tags
  has_many :mst_tags, through: :tags

  # author side
  has_many :authors
  has_many :mst_authors, through: :authors
end
