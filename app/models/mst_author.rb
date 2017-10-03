class MstAuthor < ApplicationRecord
  include ContentInfoCommon
  include ContentInfoMaster
  has_many :authors

  validates :name, length: {minimum: 1}
end
