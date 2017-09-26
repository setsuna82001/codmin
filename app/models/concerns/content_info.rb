module ContentInfo
  extend ActiveSupport::Concern

  #=====================================
  # include 俺
  #=====================================
  included do |klass|
    # included 時に ClassMethods を定義
    klass.extend ClassMethods
  end

  #=====================================
  # ClassMethods
  #=====================================
  class_methods do
    #===================================
    # ContentInfo::master
    #===================================
    def master
      Kernel::const_get "Mst#{self}".to_sym
    end
  end

  
end
