class MstTag < ApplicationRecord
  include ContentInfoMaster
  has_many :tags
end
