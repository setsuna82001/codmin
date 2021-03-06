class MstTag < ApplicationRecord
  include ContentInfoCommon
  include ContentInfoMaster
  has_many :tags

  validates :name, length: {minimum: 1}
end
