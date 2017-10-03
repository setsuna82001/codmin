module ContentInfoCommon
  extend ActiveSupport::Concern

  #=====================================
  # include 俺
  #=====================================
  included do |klass|
    # included 時に ClassMethods を定義
    klass.extend ClassMethods
    # Settings を保持
    name = klass.name.downcase.sub /^mst/, ''
    klass::const_set :RELATIONS, Settings.dig(*%I(relations #{name}))
  end

  #=====================================
  # ClassMethods
  #=====================================
  class_methods do
    #===================================
    # method_missing
    #===================================
    def method_missing name, *args
      #===================================
      # ContentInfo::master_name
      #   マスタテーブルのクラス名を返す
      # ContentInfo::master_class
      #   マスタテーブルのクラスを返す
      # ContentInfo::child_name
      #   サブテーブルのクラス名を返す
      # ContentInfo::child_class
      #   サブテーブルのクラスを返す
      #===================================
      if name =~ /^(master|child)_(name|class)$/
        obj = self::RELATIONS.dig :model, $1
        obj = Kernel::const_get obj if $2 == 'class'
        return obj
      else
        super
      end
    end
  end

end
