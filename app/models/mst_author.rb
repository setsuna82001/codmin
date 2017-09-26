class MstAuthor < ApplicationRecord
  include ContentInfoMaster
  has_many :authors
end
