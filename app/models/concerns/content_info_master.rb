module ContentInfoMaster
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
    # ContentInfo::child
    #===================================
    def child
      Kernel::const_get "#{self}"[3..-1].to_sym
    end
  end


end
