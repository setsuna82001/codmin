module ContentInfo
  extend ActiveSupport::Concern

  #=====================================
  # include 俺
  #=====================================
  included do |klass|
    # included 時に ClassMethods を定義
    klass.extend ClassMethods
    # Settingsの情報を保持
    name = klass.name.downcase.tapp
    klass::const_set :RELATIONS, Settings.dig(*%I(relations #{name}))
  end

  #=====================================
  # ClassMethods
  #=====================================
  class_methods do
    #===================================
    # ContentInfo::master_name
    #   マスタテーブルのクラス名を返す
    #===================================
    def master_name
      self::RELATIONS.dig *%i(model master)
    end
    #===================================
    # ContentInfo::master_class
    #   マスタテーブルのクラスを返す
    #===================================
    def master_class
      Kernel::const_get master_name
    end
  end

end
