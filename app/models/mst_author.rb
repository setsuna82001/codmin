class MstAuthor < ApplicationRecord
  include ContentInfoMaster
  has_many :authors

  validates :name, length: {minimum: 1}
end
